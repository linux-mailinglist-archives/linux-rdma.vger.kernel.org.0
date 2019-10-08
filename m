Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24FA7CEFF2
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2019 02:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfJHAjo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Oct 2019 20:39:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34950 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbfJHAjo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Oct 2019 20:39:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x980cx8O177512
        for <linux-rdma@vger.kernel.org>; Tue, 8 Oct 2019 00:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2019-08-05;
 bh=Ye4PMka0GL7ppfk2r5jMXYiK7jFyNryBMlJ2Gur/8+Q=;
 b=S019k1lcLRea9uBAzc3df6hWWvvrg1Y6MCTBBQtDyZR49IfOa4VxzOuQX8jaGENKLIEW
 nIVuo7BbK/MeQQfTxE5+oLc8CHUEtOqo2Td9fU//p3YYzFipUvKn2YSXDRDyhLNmO73G
 5MAZ0qLMCJ4QN68cCGahL0fRGlqn1dScDp8VwwgxRwv3koG8do+B+iNSj+bRRJfZFICl
 14tKr8OLz7KeGP47/pe5KdsrGkpeCmx6487aEmiKghapIpUlrYW6XaK5UlDf4i38xsex
 5OLfa0McE8KL9LYWE+5S4cj5dHbED4fgeDnj1ja7WVZKGP6O7GfTQh5bn667AeSUFN3m xA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vek4qa2ma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Tue, 08 Oct 2019 00:39:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x980dftd077917
        for <linux-rdma@vger.kernel.org>; Tue, 8 Oct 2019 00:39:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2vgeuwkxkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Tue, 08 Oct 2019 00:39:40 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x980ctRb031557
        for <linux-rdma@vger.kernel.org>; Tue, 8 Oct 2019 00:38:56 GMT
Received: from [10.132.91.169] (/10.132.91.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Oct 2019 17:38:55 -0700
Subject: Re: [PATCH] net/mlx5: Fixed a typo in a comment in esw_del_uc_addr()
From:   Qing Huang <qing.huang@oracle.com>
To:     linux-rdma@vger.kernel.org
References: <20190921004928.24349-1-qing.huang@oracle.com>
Message-ID: <20889bb7-0b36-831f-faa1-6bfe0e70dd94@oracle.com>
Date:   Mon, 7 Oct 2019 17:38:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190921004928.24349-1-qing.huang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910080005
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910080005
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I know this is not critical. Maybe someone can merge this or fix it with 
other commits? Thanks.

On 9/20/19 5:49 PM, Qing Huang wrote:
> Changed "managerss" to "managers".
>
> Fixes: a1b3839ac4a4 ("net/mlx5: E-Switch, Properly refer to the esw manager vport")
> Signed-off-by: Qing Huang <qing.huang@oracle.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/eswitch.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> index 81e03e4..48642b8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> @@ -530,7 +530,7 @@ static int esw_del_uc_addr(struct mlx5_eswitch *esw, struct vport_addr *vaddr)
>   	u16 vport = vaddr->vport;
>   	int err = 0;
>   
> -	/* Skip mlx5_mpfs_del_mac for eswitch managerss,
> +	/* Skip mlx5_mpfs_del_mac for eswitch managers,
>   	 * it is already done by its netdev in mlx5e_execute_l2_action
>   	 */
>   	if (!vaddr->mpfs || esw->manager_vport == vport)
