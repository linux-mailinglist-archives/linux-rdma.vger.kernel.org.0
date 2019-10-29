Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18F5FE9124
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 21:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfJ2U6Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 16:58:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50760 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfJ2U6X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Oct 2019 16:58:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TKs8mn096191;
        Tue, 29 Oct 2019 20:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=+uvSwq9SA2egPotnUwozc3qtAJKZQGfqSvE+bOmm3MA=;
 b=hAfBZOy3J8qyHEnSjd9xpISBTMkPkgGVZaOMh93uCZpN0PM5KFR5qV7CQV7iXX9jOArE
 fYFRG4/j0DGgsuh3zX25rALutltma6x6c+iH1PSyBXJhb8wm42sc5hpfBDCedL2KYZFh
 sRqWdtBBzWWWfrfc1l9nGXOmcJ7OmaQKeR1oGEyGuE9Tpm8TODo9xf8dMunVNAiTq9+P
 JJTLzpGvyKIPylIysu/XuAwPJCQ1Nj2jPWaAtr7xbd09G+PS8fdQtDv1RpyQxKAPz9l2
 oblsP7Un4HboSgAwoBxo0fporzvXe8lJYfmF2A5HNZ6Pf7ZUld77AFBy7hSXoG7dDl5D zA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2vvumfgs8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 20:58:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TKrQka007560;
        Tue, 29 Oct 2019 20:58:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2vxpfdrmrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 20:58:08 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9TKw7in009847;
        Tue, 29 Oct 2019 20:58:07 GMT
Received: from [192.168.1.2] (/109.189.94.39)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Oct 2019 13:58:07 -0700
Subject: Re: [PATCH rdma-next] RDMA/cma: Use ACK timeout for RoCE
 packetLifeTime
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     dledford@redhat.com, leon@kernel.org, parav@mellanox.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1572003721-26368-1-git-send-email-dag.moxnes@oracle.com>
 <20191029195101.GA1654@ziepe.ca>
From:   Dag Moxnes <dag.moxnes@oracle.com>
Message-ID: <3ce751b9-7f74-e197-f15c-cf76ffd1dd71@oracle.com>
Date:   Tue, 29 Oct 2019 21:58:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191029195101.GA1654@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910290183
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910290183
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

Den 29.10.2019 20:51, skrev Jason Gunthorpe:
> On Fri, Oct 25, 2019 at 01:42:01PM +0200, Dag Moxnes wrote:
>> The cma is currently using a hard-coded value, CMA_IBOE_PACKET_LIFETIME,
>> for the PacketLifeTime, as it can not be determined from the network.
>> This value might not be optimal for all networks.
>>
>> The cma module supports the function rdma_set_ack_timeout to set the
>> ACK timeout for a QP associated with a connection. As per IBTA 12.7.34
>> local ACK timeout = (2 * PacketLifeTime + Local CA’s ACK delay).
>> Assuming a negligible local ACK delay, we can use
>> PacketLifeTime = local ACK timeout/2
>> as a reasonable approximation for RoCE networks.
>>
>> Signed-off-by: Dag Moxnes <dag.moxnes@oracle.com>
>> Change-Id: I200eda9d54829184e556c3c55d6a8869558d76b2
> Please don't send Change-Id to the public lists. Run checkpatch before
> sending.
>
> Otherwise this seems reasonable to me..
Thanks for the review. Sorry about the Change-Id. I will send a v2 patch 
without it.

Regards,
-Dag
>
> Jason

