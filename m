Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F6024D1B7
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Aug 2020 11:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgHUJt6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Aug 2020 05:49:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43964 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgHUJt5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Aug 2020 05:49:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07L9gMlm082026;
        Fri, 21 Aug 2020 09:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=orjAXZiNJh1MaoNFDKY8bEIm3QOf3FaECDDCfTCafAA=;
 b=nf3gJW5wWhdtOqFrWIJBzI1j8cwnInu1ZZnwJ0QrlK6Lx/tjSwGOXgNfOnuxsphgN7QG
 Ml7LRwxDjHaQ5FKUAMj6H2ZWST0U6Uoe0mjBLJ/7lYpC5ue+UaV7c/5S0ZXXHj9EGwDa
 ZRV7Ap0OS3YYiiDFK+l32hC1S4OngfOj/274jR5hbID26wXE5YG29x5VvGsK64QPD6EI
 f38BgdtnXfn5kRMLtrKgNUYPrWwLoH009sbTWdg1MACyn8GWfLe5gs+ELfoi7ZthoIO8
 KhQOC2sxjWu9U6jR5YeSeOeyv2/6RdK5c08P3l8dBp1OQrHnGWEIMJuM8snfzRZG+mMY aQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 32x74rnaux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Aug 2020 09:49:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07L9iYoF028593;
        Fri, 21 Aug 2020 09:47:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 331b2ejg71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 09:47:45 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07L9laAQ000738;
        Fri, 21 Aug 2020 09:47:36 GMT
Received: from dhcp-10-175-160-47.vpn.oracle.com (/10.175.160.47)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Aug 2020 09:47:35 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] IB/uverbs: Fix memleak in ib_uverbs_add_one
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20200821081013.4762-1-dinghao.liu@zju.edu.cn>
Date:   Fri, 21 Aug 2020 11:47:32 +0200
Cc:     kjlu@umn.edu, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Michel Lespinasse <walken@google.com>,
        Ariel Elior <ariel.elior@marvell.com>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E59593D2-E7F5-4D41-B6DC-B8B8C55241CE@oracle.com>
References: <20200821081013.4762-1-dinghao.liu@zju.edu.cn>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9719 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=62 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9719 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=62 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210089
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 21 Aug 2020, at 10:10, Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
>=20
> When ida_alloc_max() fails, uverbs_dev should be freed
> just like when init_srcu_struct() fails. It's the same
> for the error paths after this call.
>=20
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
> drivers/infiniband/core/uverbs_main.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/infiniband/core/uverbs_main.c =
b/drivers/infiniband/core/uverbs_main.c
> index 37794d88b1f3..c6b4e3e2aff6 100644
> --- a/drivers/infiniband/core/uverbs_main.c
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@ -1170,6 +1170,7 @@ static int ib_uverbs_add_one(struct ib_device =
*device)
> 		ib_uverbs_comp_dev(uverbs_dev);
> 	wait_for_completion(&uverbs_dev->comp);
> 	put_device(&uverbs_dev->dev);
> +	kfree(uverbs_dev);

Isn't this taken care of by the *release* function pointer, which =
happens to be ib_uverbs_release_dev() ?


Thxs, H=C3=A5kon

> 	return ret;
> }
>=20
> --=20
> 2.17.1
>=20

