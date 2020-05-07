Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE211C9A7D
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2020 21:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgEGTGZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 May 2020 15:06:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:32851 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGTGY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 7 May 2020 15:06:24 -0400
IronPort-SDR: tx1lH90gtun0OoXkVoo0vdV9VtoHJczGlzbSqgzAC1/TkzlOqu6YZuXQZJeIgEqApVzddr66t4
 JHGCz2P1+WHg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 12:06:24 -0700
IronPort-SDR: guEJI6QdB4JnDxvQ1Mq2aSg91Ob1rXZfXY7LchJKwdaCb36rH3WEjycs5o/YgfpM1+OOH1PHdz
 QgYxAMyFgpXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,364,1583222400"; 
   d="scan'208";a="250175486"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga007.fm.intel.com with ESMTP; 07 May 2020 12:06:22 -0700
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 7 May 2020 12:06:05 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 7 May 2020 12:06:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 7 May 2020 12:06:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nh3PqvG+JSNkCwiva/kkAL38JLuGSsYSTzju0eUM6qF6VuPQAeVM3DfjZXUd/7nkuQzTwBis9a6MUV9rAiP0Q9xc7g4KH/+3WxEfi6Eavkty2wq0PDb5lVU33dMNE741MVssv9PYeDyGlJ5rBl8N6PcUfvgrgLywe6Dq83Spwr8iFn1EvzpeHFsKNu3pY74aIG8YyiPlk8CoXcAMMZPIDlWbYjnplFhKHVV/YQ5DeMiNvxmWtteEl6KI9F/GOt3jdpnkMieVnheSaoCJ1bKe3vZh9HMtUgqFwpowew10D3u4usDGgs0l5lasOpj3aITSA29hpzGS3Gq3w6tE+Axyfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJrPoDyyGXN3KnHZoauuaA5XMVDRUKk4Lvjh3BCUOU8=;
 b=hOV3Dr2ZdAtYwH7dsHqhK3HPkTN+yBNxWV3Cix9D7OGbsrVS7JazX3ashKZm3rEZYZZZEhatjpXpvjQjiF7UlZ11aSA3ffCOW1d+WHVTdcTjOWn+FLgNVmgeT0z7sRUcYvnyFQZJ+BJQ4p8/yhEMnoFuExhIK/jXDc/wxbEOjmy+P9VGDVy3sAZCFEh62nayASo58sqlWAyQhWOzEM3xzr+hK2WavuMj3+EUSJzm8BtIN2l97vDR2d9RpFjxtPt4Le9wMCV/F7NFruwaOx/LVq7Mc0y9hyOlaxFYXDG1FxmJcvgoHSdRUh50bOpotD1KooN5JdjPHP/9TCl2kAgMjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJrPoDyyGXN3KnHZoauuaA5XMVDRUKk4Lvjh3BCUOU8=;
 b=fpQk9wnhqG8lb15hiUMIjC4iKIRMffFhiBDCLBrhXeVq71hNJHoR8syVCEh3Xn2SJXNP8LJZGSFuHnW18daNwI5Dgfm8l8KUEwJOiIWEAu8KHLYFeI+deAibGogvyN6oJuH5cW7WnB3rq+MsyqUVarCGFSoymY83YyaF059UekI=
Received: from MW3PR11MB4665.namprd11.prod.outlook.com (2603:10b6:303:5d::12)
 by MW3PR11MB4553.namprd11.prod.outlook.com (2603:10b6:303:2c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 7 May
 2020 19:06:03 +0000
Received: from MW3PR11MB4665.namprd11.prod.outlook.com
 ([fe80::c008:bca9:22e9:4dc9]) by MW3PR11MB4665.namprd11.prod.outlook.com
 ([fe80::c008:bca9:22e9:4dc9%4]) with mapi id 15.20.2958.030; Thu, 7 May 2020
 19:06:03 +0000
From:   "Wan, Kaike" <kaike.wan@intel.com>
To:     Divya Indi <divya.indi@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     Gerd Rausch <gerd.rausch@oracle.com>,
        =?iso-8859-1?Q?H=E5kon_Bugge?= <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        "Rama Nichanamatlu" <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>
Subject: RE: [PATCH 1/2] IB/sa: Resolving use-after-free in ib_nl_send_msg.
Thread-Topic: [PATCH 1/2] IB/sa: Resolving use-after-free in ib_nl_send_msg.
Thread-Index: AQHWJJ6aQXXg3h4LAUmKqWczCauzqqic+2gA
Date:   Thu, 7 May 2020 19:06:03 +0000
Message-ID: <MW3PR11MB46656B7083F7C3738AACCCA3F4A50@MW3PR11MB4665.namprd11.prod.outlook.com>
References: <1588876487-5781-1-git-send-email-divya.indi@oracle.com>
 <1588876487-5781-2-git-send-email-divya.indi@oracle.com>
In-Reply-To: <1588876487-5781-2-git-send-email-divya.indi@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [72.94.197.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e847844-3779-4350-9465-08d7f2b9affc
x-ms-traffictypediagnostic: MW3PR11MB4553:
x-microsoft-antispam-prvs: <MW3PR11MB4553476368A70B5D236922D4F4A50@MW3PR11MB4553.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:499;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yEeOkVhGyHbZYmCRk7gv0PAhxIu0QF+MMZPEmN5M/6biekfpmnL3FSSZma15U6Z+lX12TyAUNaUt9/AEHrBD0vIu950/fkw+h0xPojDo1niPE5SH1ncjmzHlcTc7kTi/z062zEQjzeuNaetbDXR+3x96r+I4MgpZe+ixvbfahNJf5d6hdTPNdxDjFjgztlJJEFgaDghoyw/wU3heGry61QmMUv1Gy7UwS9qGXm8FARJs64ntAnYnOWtrw0xaeznlfDIoQHo4/xsg3kTVQnVMX03wrP1gFwKDkUuIWfzkDNTkmksZ63Ot+huXZUL9+XFL7VUydy1s/f6wV9cQ2BwGjQ7G+QXEBvUjZ3UWxPn9PCELqpWLY/Fl3/1Feso2iOlWgEgRLV8vHnCpPfpRuqleut1nORCIMSk9zwYusnSKa3gaWMxBx8Z94Jx3xTMTNrYyG42k2Wrt5Dn8l3WCtfKuTwFYzGz1Y9iHIF1Rlm07U240vfVbUFtrr6GNfCyKI0c+CfbYEfqIXAsOUDLbIX4WWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(346002)(376002)(39860400002)(136003)(33430700001)(83310400001)(6506007)(54906003)(33656002)(110136005)(71200400001)(5660300002)(66476007)(66446008)(2906002)(76116006)(66556008)(64756008)(66946007)(55016002)(86362001)(9686003)(83320400001)(4326008)(83290400001)(83300400001)(83280400001)(52536014)(33440700001)(7696005)(478600001)(26005)(8936002)(316002)(186003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +Q7+l57btlmhpcN3u9yIWv+54CwioiXbsqyY0saUqTZHz6EwvnfMoN059/S1vvfRYXyVYTJAhAnU88L16/ePBeh3RQI0kMJ7NoxO1d/jPYUlJuySvj5EoX0Q+6TMijj1lY0U1z87fFlfvTpWca/fkrWOEWLpUK1IfkOzeZdYwP2sOP/cGGVdxSoUVVCD9uZd8+e4iT0rVp99Y//di/gmOUU69yTR7Fgkvr96Gf99N3TCezbc0/wA+rFpKly1n0HPXntKcXPD8/PcbVqCL9Z/3BcF7TJzbc3dmi3wmvOeK/F4uVe6haTv5EzMDwJrUFvSPgirmwuzCuceFnuET0frlscUarr0c4uH9UhiwK+67vsr9XNqjwfN46L/E1AlCE7DeL93y+jAg1X+rd70HD9zC2XF3Z9xvc+lFFjJ3hmc1fm28LE8X0gZh9Baab/GOQW/LTUNeofz97dZWI0rhRXioFaMKVnKF0kwsTd5Nm+g7N4waj/tpXxDd95mCZ5m04HF5Ebq3x1arUdMrWMfO+JYwv0/1DB80pNv2ZVuuR/fPk16HLwT+YK0Q9AJDkH0qDRifoe8rr/dbIGBl1hOTnY0LUmx0SAivWjbSuv3sgvaSbSE+hxX88Sx6CFkhOVaf8vhK0w2NJDbqAa/Aocga7N3XUA1FdiA9MFgxMFdr4tiVdfKzCAYx/9TnTOidrFWaO04pCvpXjMoumpL+ytB01qmsrHGBTnz/w032jNgwSzGJJBYiMmfBvhlyKgi2WSsUuM6hklmKAnLTCMKKBoOsEDAj0MBKXhfpbodzRXBcsfgsL4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e847844-3779-4350-9465-08d7f2b9affc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 19:06:03.0357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ADHPVUsikfVciDn5kELN64x/O6p28b33Hg42HPGp2LImVGeWJMbokFYaWZQmmIY8LDx+9zZzOUpg/yhbE6mWlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4553
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> This patch fixes commit -
> commit 3ebd2fd0d011 ("IB/sa: Put netlink request into the request list
> before sending")'
>=20
> Above commit adds the query to the request list before ib_nl_snd_msg.
>=20
> However, if there is a delay in sending out the request (For
> eg: Delay due to low memory situation) the timer to handle request timeou=
t
> might kick in before the request is sent out to ibacm via netlink.
> ib_nl_request_timeout may release the query if it fails to send it to SA =
as
> well causing a use after free situation.
>=20
> Call Trace for the above race:
>=20
> [<ffffffffa02f43cb>] ? ib_pack+0x17b/0x240 [ib_core] [<ffffffffa032aef1>]
> ib_sa_path_rec_get+0x181/0x200 [ib_sa] [<ffffffffa0379db0>]
> rdma_resolve_route+0x3c0/0x8d0 [rdma_cm] [<ffffffffa0374450>] ?
> cma_bind_port+0xa0/0xa0 [rdma_cm] [<ffffffffa040f850>] ?
> rds_rdma_cm_event_handler_cmn+0x850/0x850
> [rds_rdma]
> [<ffffffffa040f22c>] rds_rdma_cm_event_handler_cmn+0x22c/0x850
> [rds_rdma]
> [<ffffffffa040f860>] rds_rdma_cm_event_handler+0x10/0x20 [rds_rdma]
> [<ffffffffa037778e>] addr_handler+0x9e/0x140 [rdma_cm]
> [<ffffffffa026cdb4>] process_req+0x134/0x190 [ib_addr] [<ffffffff810a02f9=
>]
> process_one_work+0x169/0x4a0 [<ffffffff810a0b2b>]
> worker_thread+0x5b/0x560 [<ffffffff810a0ad0>] ?
> flush_delayed_work+0x50/0x50 [<ffffffff810a68fb>] kthread+0xcb/0xf0
> [<ffffffff816ec49a>] ? __schedule+0x24a/0x810 [<ffffffff816ec49a>] ?
> __schedule+0x24a/0x810 [<ffffffff810a6830>] ?
> kthread_create_on_node+0x180/0x180
> [<ffffffff816f25a7>] ret_from_fork+0x47/0x90 [<ffffffff810a6830>] ?
> kthread_create_on_node+0x180/0x180
> ....
> RIP  [<ffffffffa03296cd>] send_mad+0x33d/0x5d0 [ib_sa]
>=20
> To resolve this issue, we introduce a new flag IB_SA_NL_QUERY_SENT.
> This flag Indicates if the request has been sent out to ibacm yet.
>=20
> If this flag is not set for a query and the query times out, we add it ba=
ck to
> the list with the original delay.
>=20
> To handle the case where a response is received before we could set this =
flag,
> the response handler waits for the flag to be set before proceeding with =
the
> query.
>=20
> Signed-off-by: Divya Indi <divya.indi@oracle.com>
> ---
>  drivers/infiniband/core/sa_query.c | 45
> ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>=20
> diff --git a/drivers/infiniband/core/sa_query.c
> b/drivers/infiniband/core/sa_query.c
> index 30d4c12..ffbae2f 100644
> --- a/drivers/infiniband/core/sa_query.c
> +++ b/drivers/infiniband/core/sa_query.c
> @@ -59,6 +59,9 @@
>  #define IB_SA_LOCAL_SVC_TIMEOUT_MAX		200000
>  #define IB_SA_CPI_MAX_RETRY_CNT			3
>  #define IB_SA_CPI_RETRY_WAIT			1000 /*msecs */
> +
> +DECLARE_WAIT_QUEUE_HEAD(wait_queue);
> +
>  static int sa_local_svc_timeout_ms =3D
> IB_SA_LOCAL_SVC_TIMEOUT_DEFAULT;
>=20
>  struct ib_sa_sm_ah {
> @@ -122,6 +125,7 @@ struct ib_sa_query {
>  #define IB_SA_ENABLE_LOCAL_SERVICE	0x00000001
>  #define IB_SA_CANCEL			0x00000002
>  #define IB_SA_QUERY_OPA			0x00000004
> +#define IB_SA_NL_QUERY_SENT		0x00000008
>=20
>  struct ib_sa_service_query {
>  	void (*callback)(int, struct ib_sa_service_rec *, void *); @@ -746,6
> +750,11 @@ static inline int ib_sa_query_cancelled(struct ib_sa_query
> *query)
>  	return (query->flags & IB_SA_CANCEL);
>  }
>=20
> +static inline int ib_sa_nl_query_sent(struct ib_sa_query *query) {
> +	return (query->flags & IB_SA_NL_QUERY_SENT); }
> +
>  static void ib_nl_set_path_rec_attrs(struct sk_buff *skb,
>  				     struct ib_sa_query *query)
>  {
> @@ -889,6 +898,15 @@ static int ib_nl_make_request(struct ib_sa_query
> *query, gfp_t gfp_mask)
>  		spin_lock_irqsave(&ib_nl_request_lock, flags);
>  		list_del(&query->list);
>  		spin_unlock_irqrestore(&ib_nl_request_lock, flags);
> +	} else {
> +		query->flags |=3D IB_SA_NL_QUERY_SENT;
> +
> +		/*
> +		 * If response is received before this flag was set
> +		 * someone is waiting to process the response and release
> the
> +		 * query.
> +		 */
> +		wake_up(&wait_queue);
>  	}
>=20
>  	return ret;
> @@ -994,6 +1012,21 @@ static void ib_nl_request_timeout(struct
> work_struct *work)
>  		}
>=20
>  		list_del(&query->list);
> +
> +		/*
> +		 * If IB_SA_NL_QUERY_SENT is not set, this query has not
> been
> +		 * sent to ibacm yet. Reset the timer.
> +		 */
> +		if (!ib_sa_nl_query_sent(query)) {
> +			delay =3D msecs_to_jiffies(sa_local_svc_timeout_ms);
> +			query->timeout =3D delay + jiffies;
> +			list_add_tail(&query->list, &ib_nl_request_list);
> +			/* Start the timeout if this is the only request */
> +			if (ib_nl_request_list.next =3D=3D &query->list)
> +				queue_delayed_work(ib_nl_wq,
> &ib_nl_timed_work,
> +						delay);
> +			break;
> +		}
>  		ib_sa_disable_local_svc(query);
>  		/* Hold the lock to protect against query cancellation */
>  		if (ib_sa_query_cancelled(query))
> @@ -1123,6 +1156,18 @@ int ib_nl_handle_resolve_resp(struct sk_buff
> *skb,
>=20
>  	send_buf =3D query->mad_buf;
>=20
> +	/*
> +	 * Make sure the IB_SA_NL_QUERY_SENT flag is set before
> +	 * processing this query. If flag is not set, query can be accessed in
> +	 * another context while setting the flag and processing the query
> will
> +	 * eventually release it causing a possible use-after-free.
> +	 */
> +	if (unlikely(!ib_sa_nl_query_sent(query))) {
> +		spin_unlock_irqrestore(&ib_nl_request_lock, flags);
> +		wait_event(wait_queue, ib_sa_nl_query_sent(query));
> +		spin_lock_irqsave(&ib_nl_request_lock, flags);
> +	}
> +
>  	if (!ib_nl_is_good_resolve_resp(nlh)) {
>  		/* if the result is a failure, send out the packet via IB */
>  		ib_sa_disable_local_svc(query);
> --
> 1.8.3.1

Reviewd-by:  Kaike Wan <Kaike.wan@intel.com>

