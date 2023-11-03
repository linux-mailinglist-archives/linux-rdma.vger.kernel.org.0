Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6C07E007E
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Nov 2023 11:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbjKCIN4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Nov 2023 04:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbjKCINy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Nov 2023 04:13:54 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F1D131;
        Fri,  3 Nov 2023 01:13:51 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A37sfe0014915;
        Fri, 3 Nov 2023 08:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=zMP5Blu3Ei7JyRR3CHb7v8/yp0ZTd6P7rHplart82eg=;
 b=iszAVqIcUgVWLLcg83jES5zs43kk3pTLO2aPWxVFyxfDl885gQzKYTWHStTgS708ZVrN
 rxxzph1EmI2jFEuaO2025hWqSvQp7AvIyq/y3aSc6lY7Ms77YpRbvp/uANWDZjgMyQ0V
 KE4/MAWbdQy/x9nKnmv/6q4tbMYOMPbkudCy1I5f48USKXBN9kEvkhHtIm05rqwLMkxb
 5MR/vqEVBMPSJ8loj7DuFhPxPL1csNmWaOkSLn/RvvUF0p1Xf/j2/WZNxSIS6CQFWhvR
 itbBmwgxzkaz/FQrAzpbm06x39hWFqX7cbpAurGOwfJyQz11vJ0SYZYT8yymy9iJwC8j Jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u4vvt8dct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 08:13:46 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A38BCXM002545;
        Fri, 3 Nov 2023 08:13:46 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u4vvt8dcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 08:13:46 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3815s7031388;
        Fri, 3 Nov 2023 08:13:45 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1fb2m2n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 08:13:45 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A38Disg26673708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Nov 2023 08:13:44 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 091815805C;
        Fri,  3 Nov 2023 08:13:44 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48A4358054;
        Fri,  3 Nov 2023 08:13:42 +0000 (GMT)
Received: from [9.171.80.36] (unknown [9.171.80.36])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Nov 2023 08:13:42 +0000 (GMT)
Message-ID: <d4bf228b-3f58-4c1a-97fb-ae6ceb25f544@linux.ibm.com>
Date:   Fri, 3 Nov 2023 09:13:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/3] bugfixs for smc
Content-Language: en-GB
To:     "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, wintera@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1698991660-82957-1-git-send-email-alibuda@linux.alibaba.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <1698991660-82957-1-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZzL5E2iQc1qFo8EX5qy2w19ae3ZhD_pr
X-Proofpoint-GUID: OCuD6J1ndabIgZe3Er32Q0S3wzBTViCt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_07,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 phishscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 03.11.23 07:07, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> This patches includes bugfix following:
> 
> 1. hung state
> 2. sock leak
> 3. potential panic
> 
> We have been testing these patches for some time, but
> if you have any questions, please let us know.
> 
> --
> v1:
> Fix spelling errors and incorrect function names in descriptions
> 
> v2->v1:
> Add fix tags for bugfix patch
> 
> D. Wythe (3):
>    net/smc: fix dangling sock under state SMC_APPFINCLOSEWAIT
>    net/smc: allow cdc msg send rather than drop it with NULL sndbuf_desc
>    net/smc: put sk reference if close work was canceled
> 
>   net/smc/af_smc.c    |  4 ++--
>   net/smc/smc.h       |  5 +++++
>   net/smc/smc_cdc.c   | 11 +++++------
>   net/smc/smc_close.c |  5 +++--
>   4 files changed, 15 insertions(+), 10 deletions(-)
> 

Thank you for the fixes, LGTM! For all of the 3 pathces:

Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
