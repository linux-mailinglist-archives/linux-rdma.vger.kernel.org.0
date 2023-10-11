Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0827C7C4D73
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Oct 2023 10:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344899AbjJKIoa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Oct 2023 04:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjJKIo3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Oct 2023 04:44:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4A394;
        Wed, 11 Oct 2023 01:44:27 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39B8RUv5019014;
        Wed, 11 Oct 2023 08:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=CKLbAFMH6LvLAXG8dHAwMBaeUjwDW9MIJWByHMsusBI=;
 b=dT+tBHk6CNe7U86tGoKC9np3s6vIL602iOt11ZzW4bf3TkKG6pvYvo5ZyiNedDzR61Qx
 TZf3qk0nqursWf0jDSPOqU9sxQMxUPbFAz03hLYvCblnF8Vppv+542w2++XHybGVFVog
 L394/egviRXuSn/4wZgYXynrxJSbh2Dm5KpyUuyQKjDsFn71R8tlPpVm2/vL//T+P1FQ
 xZ8t6I16+5cUhqHK6tIVywYy5FzGWupnoEbRCn0AxMwwM4pEaY8c6dK8ANxtwZc2wLQC
 ZwNbjeYrhWZ3LfIbVBTzyauHwybQG1Yde1Si2onHWJqVI5VFkKNEhpE21518oj32cutR bA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnr78gn50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 08:44:25 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39B8Rtut020491;
        Wed, 11 Oct 2023 08:44:24 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnr78gn2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 08:44:24 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39B6bgpi001239;
        Wed, 11 Oct 2023 08:44:22 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkkvjxdab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 08:44:21 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39B8iJHr12911180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 08:44:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BEBC2004D;
        Wed, 11 Oct 2023 08:44:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE55A20043;
        Wed, 11 Oct 2023 08:44:18 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 11 Oct 2023 08:44:18 +0000 (GMT)
Date:   Wed, 11 Oct 2023 10:44:16 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     "D. Wythe" <alibuda@linux.alibaba.com>
Cc:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        wintera@linux.ibm.com, kuba@kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH net 2/5] net/smc: fix incorrect barrier usage
Message-ID: <20231011084416.6942-A-hca@linux.ibm.com>
References: <1697009600-22367-1-git-send-email-alibuda@linux.alibaba.com>
 <1697009600-22367-3-git-send-email-alibuda@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697009600-22367-3-git-send-email-alibuda@linux.alibaba.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TGVlvUGEnTMcc16Bx-3_7D9l1mGSpslk
X-Proofpoint-ORIG-GUID: N9KOuIc_ajiHmIrov9IAuuB9NdAT0JMh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_06,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=295 clxscore=1011
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310110076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 11, 2023 at 03:33:17PM +0800, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> This patch add explicit CPU barrier to ensure memory
> consistency rather than compiler barrier.
> 
> Besides, the atomicity between READ_ONCE and cmpxhcg cannot
> be guaranteed, so we need to use atomic ops. The simple way
> is to replace READ_ONCE with xchg.
> 
> Fixes: 475f9ff63ee8 ("net/smc: fix application data exception")
> Co-developed-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

^^^
I did not Co-develop this, nor did I provide an explicit Signed-off-by.
Please don't add Signed-off-by statements which have not been explicitly
agreed on.
