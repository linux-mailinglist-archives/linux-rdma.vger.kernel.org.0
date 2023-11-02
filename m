Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868437DF037
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Nov 2023 11:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346613AbjKBKe7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Nov 2023 06:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346365AbjKBKe6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Nov 2023 06:34:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E70E112;
        Thu,  2 Nov 2023 03:34:54 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2ABDvV011474;
        Thu, 2 Nov 2023 10:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=nh1329+76M5nOlVOJuDKkaq9p7EiHpfEVsDI3xmnhpA=;
 b=JmKOXiwp9rD1i+P0hDjCfr9Ih0l8Qyt72ni8Q4h4prnlo8EGeaeTQ1BEuIyF3DvBVv0N
 rdC75cQL+W2v6Bw6a0i0gi6fo8idIdG9cBIKlYJLkwsJdk92FcuiLKm2cDlkv3p8W76g
 fQOlm73/ORU/YFkNsFVXVEumyljdlN+DddDzVZC7TClVqoEE37e2bGjfKZ9w15O5ZtrH
 pNHfnGxjCCb0Th6X+NQl/o8MfSBYbfYloDOvzydI5Jbp9PXmpyDN0n/AI05/aajq1vMz
 RufhHqML9RzvVEh+VSzmrsluVx8+2y0QqyRxBauu5UfXniQwBzEn2k50ZRS7+WjUPT3s rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u49ca16ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Nov 2023 10:34:44 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A2AIZcm002402;
        Thu, 2 Nov 2023 10:34:44 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u49ca16a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Nov 2023 10:34:44 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A281BdR011533;
        Thu, 2 Nov 2023 10:34:40 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1e4m5qgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Nov 2023 10:34:39 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A2AYcZb30606074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Nov 2023 10:34:38 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D91C58062;
        Thu,  2 Nov 2023 10:34:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D74058057;
        Thu,  2 Nov 2023 10:34:37 +0000 (GMT)
Received: from [9.171.80.36] (unknown [9.171.80.36])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  2 Nov 2023 10:34:36 +0000 (GMT)
Message-ID: <72b57457-43e1-49f7-9670-08bbf03231e1@linux.ibm.com>
Date:   Thu, 2 Nov 2023 11:34:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/3] net/smc: fix dangling sock under state
 SMC_APPFINCLOSEWAIT
Content-Language: en-GB
To:     "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, wintera@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1698904324-33238-1-git-send-email-alibuda@linux.alibaba.com>
 <1698904324-33238-2-git-send-email-alibuda@linux.alibaba.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <1698904324-33238-2-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4UCN7fX6S7yhT0S3250Irt4531Lf5wCt
X-Proofpoint-ORIG-GUID: nR28fanZk61zekQwhGB696oH3mq08EQ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1011 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=841 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020084
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 02.11.23 06:52, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> Considering scenario:
> 
> 				smc_cdc_rx_handler
> __smc_release
> 				sock_set_flag
> smc_close_active()
> sock_set_flag
> 
> __set_bit(DEAD)			__set_bit(DONE)
> 
> Dues to __set_bit is not atomic, the DEAD or DONE might be lost.
> if the DEAD flag lost, the state SMC_CLOSED  will be never be reached
> in smc_close_passive_work:
> 
> if (sock_flag(sk, SOCK_DEAD) &&
> 	smc_close_sent_any_close(conn)) {
> 	sk->sk_state = SMC_CLOSED;
> } else {
> 	/* just shutdown, but not yet closed locally */
> 	sk->sk_state = SMC_APPFINCLOSEWAIT;
> }
> 
> Replace sock_set_flags or __set_bit to set_bit will fix this problem.
> Since set_bit is atomic.
> 
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Fixes tag?
