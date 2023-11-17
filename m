Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9B27EF2B1
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Nov 2023 13:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjKQMgO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Nov 2023 07:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjKQMgN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Nov 2023 07:36:13 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA33D4D;
        Fri, 17 Nov 2023 04:36:08 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHCZqrf025251;
        Fri, 17 Nov 2023 12:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VFrrJONvLmL4b2eHMwp2aJoejodP1lZ42Ka/u1xyYsI=;
 b=aKJz0heSn7f6wiuTdoZkYhIL8tQVQOqtsWnwlIc3mUttpx1V0tRpn/glGbW2hsvSLVip
 RF3kHvuNXY4NCDxVRI+G1Sgap7Ku8U0NNZQ2CeQMSeMuXF0qFfSigtuAqYhO4oyDwn/S
 8Fk2z07WGAOx3O4yh5lxrk+/Yz0x+ZYiLfbZ9BIKPMQMbrTSki75SK+RR81kp5jFTPYH
 gI2VJKcbv1VOVnfj7XQuWBahsO+lZokCGwGegHTlINaTAVWoQdXqPLYvyay4ye+xGGTD
 UpGuNPWae/sqPswrpT3bTZopaWiqtfpaw4OOD/Yr75O6DBcA2mJVYijinhoTRtA3J/s/ bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ue7trrx4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 12:36:05 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AHCZwWD026197;
        Fri, 17 Nov 2023 12:36:05 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ue7trrx1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 12:36:04 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHAYG8M005594;
        Fri, 17 Nov 2023 12:36:01 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamayx14a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 12:36:00 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AHCa06p16843452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 12:36:00 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2094A58058;
        Fri, 17 Nov 2023 12:36:00 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEE805805B;
        Fri, 17 Nov 2023 12:35:57 +0000 (GMT)
Received: from [9.171.21.89] (unknown [9.171.21.89])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Nov 2023 12:35:57 +0000 (GMT)
Message-ID: <7fe3a213-3d2e-42d5-b44b-bbd761a01bba@linux.ibm.com>
Date:   Fri, 17 Nov 2023 13:35:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/smc: avoid data corruption caused by decline
Content-Language: en-GB
To:     "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, wintera@linux.ibm.com, guwen@linux.alibaba.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1700197181-83136-1-git-send-email-alibuda@linux.alibaba.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <1700197181-83136-1-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: anPyA8iWLD8gqgkN3Rk6WnFnb1TwYNEH
X-Proofpoint-ORIG-GUID: zGlS5DiPKERTsYoFDxchQkZyJoe0WWff
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_11,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=777 malwarescore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170093
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 17.11.23 05:59, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> We found a data corruption issue during testing of SMC-R on Redis
> applications.
> 
> The benchmark has a low probability of reporting a strange error as
> shown below.
> 
> "Error: Protocol error, got "\xe2" as reply type byte"
> 
> Finally, we found that the retrieved error data was as follows:
> 
> 0xE2 0xD4 0xC3 0xD9 0x04 0x00 0x2C 0x20 0xA6 0x56 0x00 0x16 0x3E 0x0C
> 0xCB 0x04 0x02 0x01 0x00 0x00 0x20 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0xE2
> 
> It is quite obvious that this is a SMC DECLINE message, which means that
> the applications received SMC protocol message.
> We found that this was caused by the following situations:
> 
> client			server
> 	   proposal
> 	------------->
> 	   accept
> 	<-------------
> 	   confirm
> 	------------->
> wait confirm
> 
> 	 failed llc confirm
> 	    x------
> (after 2s)timeout
> 			wait rsp
> 
> wait decline
> 
> (after 1s) timeout
> 			(after 2s) timeout
> 	    decline
> 	-------------->
> 	    decline
> 	<--------------
> 
> As a result, a decline message was sent in the implementation, and this
> message was read from TCP by the already-fallback connection.
> 
> This patch double the client timeout as 2x of the server value,
> With this simple change, the Decline messages should never cross or
> collide (during Confirm link timeout).
> 
> This issue requires an immediate solution, since the protocol updates
> involve a more long-term solution.
> 

Hi D.Wythe,

I think you understood me wrong. I mean we don't need sysctl. I like the 
first version more, where you just need to add some comments in the code.

Thanks,
Wenjia
