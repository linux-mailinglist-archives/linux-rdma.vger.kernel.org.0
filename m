Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 157A011A91B
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2019 11:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfLKKmV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Dec 2019 05:42:21 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58852 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfLKKmU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Dec 2019 05:42:20 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBBAdlGF083364;
        Wed, 11 Dec 2019 10:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=HaR6o0Wj6fuHk4UjCyD8N+jb+JZO/UMuDq33VUHYbeg=;
 b=aTm2hVYsmUzstUkXsSIaM+6j64ri7kmNSazrfY4EC/ngZUzhvDvvgLY6vBBadY+cRsv4
 BeWGyK4Vqh8+5FYMfJp4eyYxEwvCnisHoJhjONxsTWeAMw9P2ILsph9rXhhbeY8dCHwJ
 kvETPJzbFbtcM6VXzGmpMiEOT+g0ddvivruaCpHvJQp5jPFSE8l5qHJ9NDFRdW7QtoVM
 uJOpAn/ci11yuP6W7v0ZAfDlnos3G2RSeE4TAMkwNT7v8K1SgofVfXdusFA5Vf30OaiS
 WYiP64Jrlg6CKbl4mHtpV0VAfhcP5V81dlxo6JK8OoKfVK5yk71I+o2jQEPnlUJ5rGZG zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2wr41qbtvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 10:42:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBBAdkxb130027;
        Wed, 11 Dec 2019 10:42:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2wtk2ha6ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 10:42:13 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBBAgCfY017960;
        Wed, 11 Dec 2019 10:42:12 GMT
Received: from dhcp-10-172-157-208.no.oracle.com (/10.172.157.208)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Dec 2019 02:42:12 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH RDMA/netlink] RDMA/netlink: Adhere to returning zero on
 success
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20191211103400.2949140-1-haakon.bugge@oracle.com>
Date:   Wed, 11 Dec 2019 11:42:08 +0100
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>,
        Mark Haywood <mark.haywood@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7979B7AE-21A3-46E3-9F7C-52172DD94928@oracle.com>
References: <20191211103400.2949140-1-haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
X-Mailer: Apple Mail (2.3601.0.10)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9467 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=11 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912110094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9467 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=11 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912110094
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 11 Dec 2019, at 11:34, H=C3=A5kon Bugge <haakon.bugge@oracle.com> =
wrote:
>=20
> In rdma_nl_rcv_skb(), the local variable err is assigned the return
> value of the supplied callback function, which could be one of
> ib_nl_handle_resolve_resp(), ib_nl_handle_set_timeout(), or
> ib_nl_handle_ip_res_resp(). These three functions all return skb->len
> on success.
>=20
> rdma_nl_rcv_skb() is merely a copy of netlink_rcv_skb(). The callback
> functions used by the latter have the convention: "Returns 0 on
> success or a negative error code".
>=20
> In particular, the statement (equal for both functions):
>=20
>   if (nlh->nlmsg_flags & NLM_F_ACK || err)
>=20
> implies that rdma_nl_rcv_skb() always will ack a message, independent
> of the NLM_F_ACK being set in nlmsg_flags or not.
>=20
> The fix could be to change the above statement, but it is better to
> keep the two *_rcv_skb() functions equal in this respect and instead
> change the callback functions in the rdma subsystem to the correct
> convention.
>=20
> Suggested-by: Mark Haywood <mark.haywood@oracle.com>
> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
> Tested-by: Mark Haywood <mark.haywood@oracle.com>

If accepted, please add:

Fixes: 2ca546b92a02 ("IB/sa: Route SA pathrecord query through netlink")
Fixes: ae43f8286730 ("IB/core: Add IP to GID netlink offload")

or give me a hint to send a v2.


Thxs, H=C3=A5kon

> ---
> drivers/infiniband/core/addr.c     | 2 +-
> drivers/infiniband/core/sa_query.c | 4 ++--
> 2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/addr.c =
b/drivers/infiniband/core/addr.c
> index 606fa6d86685..9449ed2536fa 100644
> --- a/drivers/infiniband/core/addr.c
> +++ b/drivers/infiniband/core/addr.c
> @@ -139,7 +139,7 @@ int ib_nl_handle_ip_res_resp(struct sk_buff *skb,
> 	if (ib_nl_is_good_ip_resp(nlh))
> 		ib_nl_process_good_ip_rsep(nlh);
>=20
> -	return skb->len;
> +	return skb->len > 0 ? 0 : skb->len;
> }
>=20
> static int ib_nl_ip_send_msg(struct rdma_dev_addr *dev_addr,
> diff --git a/drivers/infiniband/core/sa_query.c =
b/drivers/infiniband/core/sa_query.c
> index 8917125ea16d..dc249e382367 100644
> --- a/drivers/infiniband/core/sa_query.c
> +++ b/drivers/infiniband/core/sa_query.c
> @@ -1068,7 +1068,7 @@ int ib_nl_handle_set_timeout(struct sk_buff =
*skb,
> 	}
>=20
> settimeout_out:
> -	return skb->len;
> +	return skb->len > 0 ? 0 : skb->len;
> }
>=20
> static inline int ib_nl_is_good_resolve_resp(const struct nlmsghdr =
*nlh)
> @@ -1139,7 +1139,7 @@ int ib_nl_handle_resolve_resp(struct sk_buff =
*skb,
> 	}
>=20
> resp_out:
> -	return skb->len;
> +	return skb->len > 0 ? 0 : skb->len;
> }
>=20
> static void free_sm_ah(struct kref *kref)
> --=20
> 2.20.1
>=20

