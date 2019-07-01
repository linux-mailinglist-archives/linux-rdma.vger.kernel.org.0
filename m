Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0555B6A4
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2019 10:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfGAIQk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Jul 2019 04:16:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55720 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfGAIQk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Jul 2019 04:16:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x618Dinn145844;
        Mon, 1 Jul 2019 08:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=kgVacouauQHI9OW/H6gsmT8XutMDGiKaG4jLaQexuyo=;
 b=WPnjQHtM5q+2IQBBcH+Dlm8iwjikslCoWjA7jvMu6p03P8qZuVIOAx6hd+IfKb6feGEe
 FvdPEJRrP2tp5yqFHXmQo46kT+ksPAcnI9sQaMFp7FH88EBWXcisPalMNPs84gqRiX0y
 vzb7WO4dWYBGhaPK5GmBBJdxnaoO1WG9lc4EBKgO6WcSHPcCGxpCeu4wYfMz77nY8taD
 hIf/8qfoCtkuNzH4YUmal2NtIVwxHQAJgcTgnRrAbGONu2835/E6HOOnPyOQsQuX2GuG
 5eTK3VH+VfL7sT183AJnxFwNC7GmyIKfipYy9kevrDAy1l7c+r3KG13ZeLsTEGolPNpt lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2te61pm2m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 08:15:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x618D2ki084470;
        Mon, 1 Jul 2019 08:15:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2tebak239r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 08:15:50 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x618FoVB013176;
        Mon, 1 Jul 2019 08:15:50 GMT
Received: from srabinov-laptop (/10.175.26.189)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 01:15:49 -0700
Date:   Mon, 1 Jul 2019 11:15:42 +0300
From:   Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To:     Yuval Shaia <yuval.shaia@oracle.com>
Cc:     yishaih@mellanox.com, dledford@redhat.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org, jgg@mellanox.com,
        mark.haywood@oracle.com, Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH v6 rdma-core] verbs: Introduce a new reg_mr API for
 virtual address space
Message-ID: <20190701081542.GA30149@srabinov-laptop>
References: <20190613110936.30535-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613110936.30535-1-yuval.shaia@oracle.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9304 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=9 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907010103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9304 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=9 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907010103
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 13, 2019 at 02:09:36PM +0300, Yuval Shaia wrote:
> The virtual address that is registered is used as a base for any address
> passed later in post_recv and post_send operations.
> 
> On some virtualized environment this is not correct.
> 
> A guest cannot register its memory so hypervisor maps the guest physical
> address to a host virtual address and register it with the HW. Later on,
> at datapath phase, the guest fills the SGEs with addresses from its
> address space.
> Since HW cannot access guest virtual address space an extra translation
> is needed to map those addresses to be based on the host virtual address
> that was registered with the HW.
> This datapath interference affects performances.
> 
> To avoid this, a logical separation between the address that is
> registered and the address that is used as a offset at datapath phase is
> needed.
> This separation is already implemented in the lower layer part
> (ibv_cmd_reg_mr) but blocked at the API level.
> 
> Fix it by introducing a new API function which accepts an address from
> guest virtual address space as well, to be used as offset for later
> datapath operations.
> 
> Also update the PABI to v25
> 
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> ---
> v0 -> v1:
> 	* Change reg_mr callback signature instead of adding new callback
> 	* Add the new API to libibverbs/libibverbs.map.in
> v1 -> v2:
> 	* Do not modify reg_mr signature for version 1.0
> 	* Add note to man page
> v2 -> v3:
> 	* Rename function to reg_mr_iova (and arg-name to iova)
> 	* Some checkpatch issues not related to this fix but detected now
> 		* s/__FUNCTION__/__func
> 		* WARNING: function definition argument 'void *' should
> 		  also have an identifier name
> v3 -> v4:
> 	* Fix commit message as suggested by Adit Ranadiv
> 	* Add support for efa
> v4 -> v5:
> 	* Update PABI
> 	* Update debian files
> v5 -> v6:
> 	* Move the new API to section in libibverbs/libibverbs.map.in
> 	  (IBVERBS_1.7) as pointed out by Mark Haywood

When will this be pulled in to rdma-core master ?

I can use this API for the shared PD demo app.

Thanks
