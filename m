Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193EA4F9C59
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 20:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiDHST6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Apr 2022 14:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiDHST5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Apr 2022 14:19:57 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB8E119248;
        Fri,  8 Apr 2022 11:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649441870; x=1680977870;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=whbHlwKDXrqtO3Rizz7JXGQzNmDE0Oiofp5Vj+DMeZ8=;
  b=cIIDZWNl1Lo6IqlSNR8vum3w/T/kmnxZibM7gp5SpmNI/Qonl+hRmemv
   x7mr5F5Xqfwi8lerS6DohqNl+kvWFI8eQl/NF32O3ryX/3mlKFFqjyIJG
   +vjLFDQvt4//4xjI0cMXyySbbKWTFItzpMBq4ijmeDuArrzwNY0epWgRU
   l6U8wOTz8fpY1B8RcSvoTM3wi9/tpzEgZbcxZi08AsgDIUPKinOt7P+tm
   1Kk8/9+DDA8vdx7m4qtcpBG/2Ckcmzc3Ne1LlFAsCf7gWcljLjsfYc/x4
   naUAIzEX1dXJexvt6c6iM9r0O5laSku2SRGSyaqUfG5fqNOuB8qgW4X5g
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="322349732"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="322349732"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 11:17:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="550598099"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 08 Apr 2022 11:17:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 8 Apr 2022 11:17:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 8 Apr 2022 11:17:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 8 Apr 2022 11:17:49 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 8 Apr 2022 11:17:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsnqjRGFps2DczqFr8XIng9HfeyLrst8b12fSpR1E4IqXXqCilHlOwoHModsxF6SUPDj9vkLgUfANA5+LVX8kviLAkXYMoxhtI56VqIATHJdHbrzuf7pFgQhOXw97ZBgDZzGBRSRT8JumecStyhuQbB2+Q8UW4oVZkznv9qBqAGA5E7MZt9GdwKrM5NGItgWcH9novOEKH7M74lxvxcY2RWWk4NNtQPthA/yBjEPXhmGcYwBNfVQHDhwQz5VwGGGwRlGy1E7hqiGaqVT4EedZxKTygNTkArGGGi3FUJDK161XPg+slS9gVRSw/U9zhMVYayNoSKUzRnS+S6TkyW/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ynh+17v/As7jHvNvpPDjwJHVbE1Xg/cWvHL5d8tsdE=;
 b=YR67mWN250P+/JPNFn072Lv0d981KgX5etLmbFR/81zRbHlCVJBxQy6Yp6ydomNGwSOvF/j2wlMqH7p7qrOX2/++jc+ohksbIp5whUDKEk1wYd2xvmxbzOOjj4k8jGurTGEv9asN1/kkQk3pKKVEBvFG+8b8zmooSMq0d0KNiAOhFTC3dKoOzt8aWMI2QzKMdoTsfLSxSu9h+aI7qdlubaJ0/TWMvd9TMDETvkVU9sebAf6mNg0ZuUEd3GmXyODt0/iQgXvGQOUDireb53RrC8dzWvb1+FSAL87BxJSJEIzTqdyVsmXsK9V0Du1E2D4zW+t7lLVMFB231HVBh3sw2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by DM6PR11MB3161.namprd11.prod.outlook.com (2603:10b6:5:e::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.22; Fri, 8 Apr 2022 18:17:46 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::ac0c:4806:934a:636c]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::ac0c:4806:934a:636c%6]) with mapi id 15.20.5123.025; Fri, 8 Apr 2022
 18:17:46 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Duoming Zhou <duoming@zju.edu.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
Subject: RE: [PATCH V4 09/11] drivers: infiniband: hw: Fix deadlock in
 irdma_cleanup_cm_core()
Thread-Topic: [PATCH V4 09/11] drivers: infiniband: hw: Fix deadlock in
 irdma_cleanup_cm_core()
Thread-Index: AQHYSvYSNtIPz+QHNUyVwleSCPhwc6zmPuQg
Date:   Fri, 8 Apr 2022 18:17:46 +0000
Message-ID: <MWHPR11MB00291BA918E17176BDB12578E9E99@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <20220408030904.34145-1-duoming@zju.edu.cn>
In-Reply-To: <20220408030904.34145-1-duoming@zju.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8183f73a-2f31-46d2-444c-08da198c14ca
x-ms-traffictypediagnostic: DM6PR11MB3161:EE_
x-microsoft-antispam-prvs: <DM6PR11MB31610EBE3C8B172CBBFD7D4DE9E99@DM6PR11MB3161.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EtKCg2uIfZPRdo9YXAwOQ3EGaZjKewbVpxmI5Sp4VrcH3KqMHIY5yEARCF/jsSOBoh37Hyt+PX+PKXSGmOh4UZM9i/kvlESjmg3c1R+zhUb6ATaFmhx9RRTbI3AAIUTmFluA+vYLPjHdr218e9Y/YP4tK0cHIsC4NOmsWl/oSiXM1k5QtUuk3+RtxEn/z8S8+Mt172eZYK6o4PZ/FxLNmSKilDraYDmGyA1n35ICLar9FELOCFrCdakXdcuPBX0XjCa5tEowAcm9krykeFRAKYv/SaW4l0eM8/NzDju9bgE+BU29+OP2QN1/4wWsI72Z1gy5mjKM+9PJcdScw3LTzozBOss8RBG+0D/IsKlWTx9b+abApnddFz7CohpzLgKVbDFCKDqx9XiYsfMjqiq/kOEM+ci4q2CvX/s6Z0vDSoewD4pVdj4ZwujnjwMYAj2xp2a8mRxtf77wWxCyHm1a9HS/+vCMO2PnDcffx9VUelZHIPZw1oqeprRnrTbb7LHGn0SRpR33SdhH2oeWaB82EYunFhXTAHfkFdXyIehwUQEbRfgdyyA9JnlT5V5iRP0bKmcNUCvWw/QapC+JPuZ8Ua+xdFTKzrt8G4fIBs0vy6qfJBLCeTiRXmfnLFmeHdbVVtyznZGQlSpOo8Y8brzu0Tcd/rrElA0NuR8adq3jntzzilARMdgkh8LUNEpKhIBDs0IGNgT7hcfZ8Mr3pUqYVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(110136005)(86362001)(8936002)(82960400001)(33656002)(316002)(122000001)(55016003)(2906002)(71200400001)(83380400001)(52536014)(38070700005)(66446008)(76116006)(38100700002)(5660300002)(7696005)(8676002)(64756008)(9686003)(508600001)(66946007)(54906003)(66556008)(4326008)(66476007)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xzCrN3rs2irvBXdrmx7P4ENmeYQLpWvE0tDux7UwgMOnM23EmFlCRPcjGsju?=
 =?us-ascii?Q?JzR5xT7/JBM6JJSLjLQXVspzbV3ILbj/2+XUySdt+5bEBqy7OtMA5klKznln?=
 =?us-ascii?Q?vicyJCCaZ/iSPnDuMecq1fGQmihNtmyfDdOp9ICv4qw9998iUFpm7NRpsyBq?=
 =?us-ascii?Q?IL1L9M4e4+G+cWpUPbO0we7Wyvmrf1dakvaJA2czRmCspscQKZeqOoRbHrEz?=
 =?us-ascii?Q?rCUqSXqyR0rz0LlXHPV9W/yLIdTyG18xpTLYyRK8j4GOJ9/F4Thdp7/dlIIw?=
 =?us-ascii?Q?W1G1xmFYNKZhyQd9EzBQbdV7C0DiweU0wUXCJMdpPkXqnK9BywFYKU2sYl61?=
 =?us-ascii?Q?IUod9AxqDc9ZwSh9+Af6mp+RETb0WawTeFnx4PikHGCYdpi5FSgulqTqpoiH?=
 =?us-ascii?Q?/oqXW2w02xJyDnDcCUCQJ3rKPSO49dyrINDpT58cBmjwUsfERi5U3afQerpF?=
 =?us-ascii?Q?+iCSY8f7sW5QnhKBRyRuEcyVIznTqU+FFJ1297GM3pQofi/TXfYQeDb/Ycdb?=
 =?us-ascii?Q?WGIty6PcYyAtsl/rD+sjh9osIJuDFPUpksL2eQejHEus3nhbQUOS+K/Fcj+z?=
 =?us-ascii?Q?1iEEPW9EYotI3pRejjqwSw4/cvU+BLSJ3hM8zk9ujnEVgzU+SnNVI3MzVXGn?=
 =?us-ascii?Q?JRc1lcXTffIV3D6VfcvbeZSTksAA2Kou+Q73Sy0HljIw8+3uyI+Op2MiD+Hf?=
 =?us-ascii?Q?a7WVapH7lFWfWaO7l4/Xh69TuT6uM1fkufrmGdDCfZ7jywaMwcBPF00yRL6Y?=
 =?us-ascii?Q?C/wGKWP1D89DYPnG0Al6QGUNtdnhs7nVX14drQ+C+gUOpaiDhyUMpNrL+LxE?=
 =?us-ascii?Q?lAq4tuOePstAUQw/sCSoZAsTlZHqnuVAH7VEjHUZtycMBkEWHdiYP8ciUkgx?=
 =?us-ascii?Q?0yNA1TZTTx6+zGsVkGZXOjnvVh2bbxqDkb6oMCh/U3FpU3gv62UW6rLpnaiz?=
 =?us-ascii?Q?h2Hj6m3WOP8hInCYwWhHi70es0YQwbuodZFI+2koOWD8xc+1eW0E39rKv+v/?=
 =?us-ascii?Q?FjutXO9TRYyZsMutiGdk3mbigcS6eEXLFVHWXyYz4nZFgzCpiL2MnC0sVl+k?=
 =?us-ascii?Q?3JC5aEd6ammjbfPJ/Doe+mZu2S/kw7nbhpbI47LW4aL9CPX8Mb7Fjbck8oz5?=
 =?us-ascii?Q?CXxuZyGbgpSh/ghXyRTKZocDmgqAI54kFcQPuCu4MOIPlmLWRRT/p9u3cqQf?=
 =?us-ascii?Q?nCn/p+VKRfw+DHeHLVbnK1zQFfwQA2AhzKGo7vp3lfnMB7Xaj54k1FWY5Gt0?=
 =?us-ascii?Q?H5JaVCymlaxYvTfncqveoBOP3vXL1yUmzs8LUyoA4Sxl98sTUiwwco4EudJ+?=
 =?us-ascii?Q?C8di1rEXBjQpvDUC/QHYGgfKiwMptI4xBWzsdkD5iVKXBbLoaeInb6X/1H4j?=
 =?us-ascii?Q?JIdUmWh8uVseAXTkB4nuFkhdsSvu8lC6ENfmIdujEteh1sXjf7Leo5Tx02Pt?=
 =?us-ascii?Q?yuuxamhUzb3q0I5nsqQYCm3MbzVdjx+Z3DekrwfhZaJgaK63MtjAOWsiYi7l?=
 =?us-ascii?Q?7mTo7GAorO4lwW6QLG1WeJXodJMPXbb+C6ybJv+a9tm+SY+ep0PVLA0H17b2?=
 =?us-ascii?Q?RaielWT/pjS9FOWL67nRaPDMpGBU2Rbog+P7Et2ZsWuVIbfhh4UTanOoWX59?=
 =?us-ascii?Q?O/BkQaIVhAS4aoxW5w4Ui9KY5eMKunkD5hafGbiYgIHZO/A9Trw+oFp0NWXG?=
 =?us-ascii?Q?p2Or9w2GHAQKWjCH3C3A8UxRHPT80NnAiI9WP+w8onaXhZfYyfy9j09z/nGy?=
 =?us-ascii?Q?VrXsOugAmA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8183f73a-2f31-46d2-444c-08da198c14ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 18:17:46.0637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CyGptmuQNuGSupiurDXt4rpVhgkExALqBk0rLrHHhwfnD1nKN+P5IMK8WmES5dxR4e1dTytv5lwSB/8An+pclA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3161
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH V4 09/11] drivers: infiniband: hw: Fix deadlock in
> irdma_cleanup_cm_core()
>=20
> There is a deadlock in irdma_cleanup_cm_core(), which is shown
> below:
>=20
>    (Thread 1)              |      (Thread 2)
>                            | irdma_schedule_cm_timer()
> irdma_cleanup_cm_core()    |  add_timer()
>  spin_lock_irqsave() //(1) |  (wait a time)
>  ...                       | irdma_cm_timer_tick()
>  del_timer_sync()          |  spin_lock_irqsave() //(2)
>  (wait timer to stop)      |  ...
>=20
> We hold cm_core->ht_lock in position (1) of thread 1 and use del_timer_sy=
nc() to
> wait timer to stop, but timer handler also need cm_core->ht_lock in posit=
ion (2) of
> thread 2.
> As a result, irdma_cleanup_cm_core() will block forever.
>=20
> This patch removes the check of timer_pending() in irdma_cleanup_cm_core(=
),
> because the del_timer_sync() function will just return directly if there =
isn't a pending
> timer. As a result, the lock is redundant, because there is no resource i=
t could
> protect.
>=20
> What`s more, we add mod_timer() in order to guarantee the timer in
> irdma_schedule_cm_timer() and irdma_cm_timer_tick() could be executed.
>=20
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
> Changes in V4:
>   - Add mod_timer() in order to guarantee the timer could be executed.
>=20
>  drivers/infiniband/hw/irdma/cm.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/ird=
ma/cm.c
> index dedb3b7edd8..e4117b978bf 100644
> --- a/drivers/infiniband/hw/irdma/cm.c
> +++ b/drivers/infiniband/hw/irdma/cm.c
> @@ -1184,6 +1184,8 @@ int irdma_schedule_cm_timer(struct irdma_cm_node
> *cm_node,
>  	if (!was_timer_set) {
>  		cm_core->tcp_timer.expires =3D new_send->timetosend;
>  		add_timer(&cm_core->tcp_timer);
> +	} else {
> +		mod_timer(&cm_core->tcp_timer, new_send->timetosend);
>  	}

There is no need to do a mod_timer. In the timer pending case, the handler =
will fire when the current armed timer expires.

The handler batch process connection nodes of interest. And this connection=
 node is marked for processing.


>  	spin_unlock_irqrestore(&cm_core->ht_lock, flags);
>=20
> @@ -1367,6 +1369,8 @@ static void irdma_cm_timer_tick(struct timer_list *=
t)
>  		if (!timer_pending(&cm_core->tcp_timer)) {
>  			cm_core->tcp_timer.expires =3D nexttimeout;
>  			add_timer(&cm_core->tcp_timer);
> +		} else {
> +			mod_timer(&cm_core->tcp_timer, nexttimeout);

ditto. Please remove.

>  		}
>  		spin_unlock_irqrestore(&cm_core->ht_lock, flags);
>  	}
> @@ -3251,10 +3255,7 @@ void irdma_cleanup_cm_core(struct irdma_cm_core
> *cm_core)
>  	if (!cm_core)
>  		return;
>=20
> -	spin_lock_irqsave(&cm_core->ht_lock, flags);
> -	if (timer_pending(&cm_core->tcp_timer))
> -		del_timer_sync(&cm_core->tcp_timer);
> -	spin_unlock_irqrestore(&cm_core->ht_lock, flags);
> +	del_timer_sync(&cm_core->tcp_timer);

This is fine.

Shiraz


