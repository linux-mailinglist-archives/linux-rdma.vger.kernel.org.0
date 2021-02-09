Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2A13151F8
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Feb 2021 15:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhBIOrt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Feb 2021 09:47:49 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35348 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbhBIOrh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Feb 2021 09:47:37 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 119Edw6e049435;
        Tue, 9 Feb 2021 14:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=OwADcq48iyQ2YNxGL9PsHghJIfRmkzraulfRDrfb/dE=;
 b=H9mbxkI+XUuQS0E0u1wyKM+CnD5d8ATIcJXUM9PYEMVIpdMPAE4p7yUNJ/WKq+fyYxHN
 Aw1PiUTaLlGF6ByTJd6nDFRcR2yOGkMGt3NHgYAWsnX6CZUxHJHyXlr3CrZabo24D4WQ
 azPUJ3pI3HQgqC1ZSBKzbd1cb9LMD5Ha9iWxusz9QDdgMlf3wMjp9Cfz8ogP+oecu+Ow
 BrmunUJ7qXqGXosnfKdD3G4KC9jrkx1cVd8ndkdvFWkx/rb/UWb2HbEt+o34lWvJza+c
 QhoBSv+ZlYfBLk19B+CditkPeUCohaY8wvbk14KnOMPyCqdHxjzbXP7FKxMsDNmvpvNJ ig== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 36hgmaftt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 14:46:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 119Eedng055385;
        Tue, 9 Feb 2021 14:46:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by userp3020.oracle.com with ESMTP id 36j4vrdk4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 14:46:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buWhD9SiXC5HL8b4QdO+Tm8AKLNIETXvvULySN7+PgYg6XaONNjHVjW5hRzCqZ8FRxItk64RwVWvYSmj/xAkd/NtFGH0wrOMRKiJ9v54V1YQzVVXWjQY3WOT/lPD/Z2LdJIhfKgemLpxSpke+TZxEp0xWhJhnkU2Ms3WTigTUIhqt2trEhJF8uWwD4tMEjeL+eqinZAwfS74NSAOhOJ0cPwesQ6SnEOnN5Cr1wSrzAIfRYTM8BzUqI4h1R9411jZvp7eN5LUEfV2cpdoBSGQSvFJR2FPI5m2s61N2ekp9dHvIF1zenaECwG+/3xVj26bEzDGWbNRx7425KzQRwxtZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwADcq48iyQ2YNxGL9PsHghJIfRmkzraulfRDrfb/dE=;
 b=TfsLvqdvmQi3noBe9oJTNzYaD3ckFWj5FodZwvrmKsRnCur+VILXCeypYSld697zP4DTyj1tZ+PiVdkqPut5eAL+YagWU/VqGoQiJveDyGUZfoPB+wfzggMMhI6gvg+hgRoFjCXrOk813WsJ4KqmkLNDxA2wMYyNmhdi7PQyKtNfhMWUYxKRIkwNSL4R34cODu9g3/7P9rq32ODnkMA39941wqJFkVlrEU9pvvENcOD/BQFaJfWpCMl5u/5TKJ+oBcqnMM9EDRkEBJ+n/lAiCrc9/v+H4CjS3Az8fBgzd4heikKfDcl9EPnLckP9vsDxU2bCfuTZpY8xo9/XmApjwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwADcq48iyQ2YNxGL9PsHghJIfRmkzraulfRDrfb/dE=;
 b=h102dM15w9uBcHv9DOOspGfR6zltAI+tavQMrC0g/VwSs2OHfuvYEekBBz0rj1fmRxE0VFKnCCtL/iEDIjqFJeYp2oXbqeW3VpdZZwP2ltlC70rPfSsbMYIC+xEXp44xQunazSSSTY06nJcJTVQM7V9/ilmwJpZ4zZSK/XjKjMw=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4510.namprd10.prod.outlook.com (2603:10b6:a03:2d6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.16; Tue, 9 Feb
 2021 14:46:48 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3846.026; Tue, 9 Feb 2021
 14:46:48 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 06/14] RDMA/cma: Add missing locking to
 rdma_accept()
Thread-Topic: [PATCH rdma-next 06/14] RDMA/cma: Add missing locking to
 rdma_accept()
Thread-Index: AQHW/vJkmiyrvjhaikij43SOTU96iA==
Date:   Tue, 9 Feb 2021 14:46:48 +0000
Message-ID: <C69C843C-A2D5-4A17-ACEE-67056864DDA7@oracle.com>
References: <20200818120526.702120-1-leon@kernel.org>
 <20200818120526.702120-7-leon@kernel.org>
In-Reply-To: <20200818120526.702120-7-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b7b070a-f528-4c93-11e3-08d8cd09876e
x-ms-traffictypediagnostic: SJ0PR10MB4510:
x-microsoft-antispam-prvs: <SJ0PR10MB4510C812FEAF09B030D84272938E9@SJ0PR10MB4510.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DTQKzUlyBpjESk7UkgDjnuLX83i2IPvJ7fviwK9EQ1Cw8E78Zys8rTfVxH8BGx2nv7U95EkpKjGrKJzu+yxqz3qx0ngF3C3iuCjRKn2afXuHmgTM9WboT9q+LPFEkfMaRmnwZnRJbs7Tac73ipVlGC/hTJgHP4gv5eFtCXDG05zZHRy8DWOdOVif35+XleiGPvojyfsbHLB0V+8Bpr5qBOxHBGQC0/gyZBEv1KR48pPrsUp7Vrha73hspgD79owgtfKWEbIjN2RsgQ/NVxtOVcLxWArcleQzbD3zimarYRF2FZG8tGUVojsgcnS2Cs9KCUrXXJizvQK62rqITGXvcspNaWUQ0u2a81OFDZ1Sq41JU7BDeGKUS6alqx01U4vWeQYFS/rdu58rm3vPeENCW3SN3e2fxpe4bvCBomh9hkLnBhcVCBfeSnOnOkw2LfPQpTU0/d4dkyWEklx7YE1RWbrKw3K7B12BDk1fdw+hPAL4r93ynZn//TPNxs/LtOKlK0Egedj/AJ0qNdwCYL4TVIJy8diptCUy+6jnCaMLShyvR+u2Il2SxqK2CNzjwRsKRY8vKe8ROGvri77xjpLsNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(39860400002)(366004)(83380400001)(86362001)(2616005)(33656002)(186003)(26005)(91956017)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(8676002)(316002)(36756003)(5660300002)(44832011)(71200400001)(8936002)(54906003)(110136005)(2906002)(6512007)(53546011)(6506007)(6486002)(4326008)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xdqXrmxOHBW+vaM5NBGqsLk7TvSQ4WHNMBxBnuUZ9kWHqWW7WWZffmFvpHTx?=
 =?us-ascii?Q?DQoKyWXLsLsFGEv4E1ONyhFSg9gPNJ+byd8fMkzj4vSehOEBEjYGQii3SPbK?=
 =?us-ascii?Q?U7y7Z+mlkA+guATAUHE4UtN1DOdS+QTddEbVZvZwytmzkWXhmcbz8XuvRCZT?=
 =?us-ascii?Q?V7YBtLtva1kMn9ZH296xMfL3zWUXD5WJ2tadKA2cByaDpaikzxT1x/3zqOpH?=
 =?us-ascii?Q?/+VpRiXZnjyb4GjwSqaduIxWKtZpiQapO78U5BFnZIWLqqIdvL2N/LBVHgwl?=
 =?us-ascii?Q?3hCA7fZXxqrWD1vkKQh14ndKmMxzsREJyUInQYa5FLA0q/x7aXH5SceyCTaW?=
 =?us-ascii?Q?i8jhrcwIB0m6JxTse7MuAawE7noCWY1f9inNHD76gcXiAR9k9exXQ2Su84Fm?=
 =?us-ascii?Q?TMBh0qimwxizRBtiGmGGYMa3Y38Dk8mYv9A+Ba1W7nJBzLlTG0ft3wUzQxk2?=
 =?us-ascii?Q?X+b1rHbbqcOmL1hu7dgQSbmzVhDODHe0jRl0qPR4RyOnKOBcuD3n5vK2ljMx?=
 =?us-ascii?Q?fdgAveJxyQdHkbhaZlM7UD98hwh1ASuKg4K0ue+yGJKIHIuOTzecwoVbTaKp?=
 =?us-ascii?Q?bCyuw6/cYG3/xszqpyxipNnKyqIDzjBYtGNhpyeI3QmsnDfHJoyf+N3e6pyk?=
 =?us-ascii?Q?bayduJoiYvWhykdKd34CGbXEt7Nd4+yHOBgPbjPg1NtW4zdcwSgkFuLet/bD?=
 =?us-ascii?Q?/4+bWFCxkU3oxW+iDFqIwiEYwZHhHC8YlQU//mMtsyPlF4K2CUwNLymw7E6C?=
 =?us-ascii?Q?P7DA2ezOLNjuxz9WaZ/I5YSEX84EIJAvcYZ7S/d4WAW9siK3ZKNZhw9uJSC2?=
 =?us-ascii?Q?eM2y6IdT6l/eln5vdGI4HMs9q489Nk1bQKMzgVBBzKLa1/7RaqIxTtPzgDNT?=
 =?us-ascii?Q?pL2GM1AhQ/0+e9rkt5xbWFvu5WH3doAyCD0uX91ez+F3gCRagj02/Ug7Dv51?=
 =?us-ascii?Q?Sp6xxVlHsw24Xf+hxIF9E29Dbr4FOw9Qc5XU9ht1R2j6zFqqt+0iIaFZpS0F?=
 =?us-ascii?Q?jZsxabmnrkF44yoi1kY9DlxfOrYieLLoYvQjDClrorMHCHrWOnmpulG7420G?=
 =?us-ascii?Q?Qui6bpTmhrlna9t2hkmyOAguq6jPpOTTu+sH6O7CaT3ddVLJAlX9RZfLGHbt?=
 =?us-ascii?Q?pouAeFldP7VFOYkAUB+PyE+cR35jbwYp3L6Krr7DEGon8SabQaPEah/g3rvQ?=
 =?us-ascii?Q?VmVzuMrNOmWKWIjF2mcS2bS5q283RtLo2Xqw7k7uKEnWzRjLy//LKO+5NrgF?=
 =?us-ascii?Q?rmbFn4+97v+JBfLQp1mgUuJsSZqQ7uJd72kyNNR4DhUK/FGGdnQYUWBmKJAo?=
 =?us-ascii?Q?xcYC01ad9OwWhOBwQbuJ+YftBq/st4TpCeX0enYn3uBxug=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D4E23FAA7C7C1A45A366475DC72FD1A3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7b070a-f528-4c93-11e3-08d8cd09876e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2021 14:46:48.2287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sSHXaM2mhwnJZG9DqZYRuoTUvElKwz86cBKGEMuwOByEz1azyqj3KlSHWlISF6umY4rlnWbkRcB4Tk63us91jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4510
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090076
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102090076
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Howdy-

> On Aug 18, 2020, at 8:05 AM, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> From: Jason Gunthorpe <jgg@nvidia.com>
>=20
> In almost all cases rdma_accept() is called under the handler_mutex by
> ULPs from their handler callbacks. The one exception was ucma which did
> not get the handler_mutex.

It turns out that the RPC/RDMA server also does not invoke rdma_accept()
from its CM event handler.

See net/sunrpc/xprtrdma/svc_rdma_transport.c:svc_rdma_accept()

When lock debugging is enabled, the lockdep assertion in rdma_accept()
fires on every RPC/RDMA connection.

I'm not quite sure what to do about this.


> To improve the understand-ability of the locking scheme obtain the mutex
> for ucma as well.
>=20
> This improves how ucma works by allowing it to directly use handler_mutex
> for some of its internal locking against the handler callbacks intead of
> the global file->mut lock.
>=20
> There does not seem to be a serious bug here, other than a DISCONNECT eve=
nt
> can be delivered concurrently with accept succeeding.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
> drivers/infiniband/core/cma.c  | 25 ++++++++++++++++++++++---
> drivers/infiniband/core/ucma.c | 12 ++++++++----
> include/rdma/rdma_cm.h         |  5 +++++
> 3 files changed, 35 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.=
c
> index 26de0dab60bb..78641858abe2 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -4154,14 +4154,15 @@ static int cma_send_sidr_rep(struct rdma_id_priva=
te *id_priv,
> int __rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_par=
am,
> 		  const char *caller)
> {
> -	struct rdma_id_private *id_priv;
> +	struct rdma_id_private *id_priv =3D
> +		container_of(id, struct rdma_id_private, id);
> 	int ret;
>=20
> -	id_priv =3D container_of(id, struct rdma_id_private, id);
> +	lockdep_assert_held(&id_priv->handler_mutex);
>=20
> 	rdma_restrack_set_task(&id_priv->res, caller);
>=20
> -	if (!cma_comp(id_priv, RDMA_CM_CONNECT))
> +	if (READ_ONCE(id_priv->state) !=3D RDMA_CM_CONNECT)
> 		return -EINVAL;
>=20
> 	if (!id->qp && conn_param) {
> @@ -4214,6 +4215,24 @@ int __rdma_accept_ece(struct rdma_cm_id *id, struc=
t rdma_conn_param *conn_param,
> }
> EXPORT_SYMBOL(__rdma_accept_ece);
>=20
> +void rdma_lock_handler(struct rdma_cm_id *id)
> +{
> +	struct rdma_id_private *id_priv =3D
> +		container_of(id, struct rdma_id_private, id);
> +
> +	mutex_lock(&id_priv->handler_mutex);
> +}
> +EXPORT_SYMBOL(rdma_lock_handler);
> +
> +void rdma_unlock_handler(struct rdma_cm_id *id)
> +{
> +	struct rdma_id_private *id_priv =3D
> +		container_of(id, struct rdma_id_private, id);
> +
> +	mutex_unlock(&id_priv->handler_mutex);
> +}
> +EXPORT_SYMBOL(rdma_unlock_handler);
> +
> int rdma_notify(struct rdma_cm_id *id, enum ib_event_type event)
> {
> 	struct rdma_id_private *id_priv;
> diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucm=
a.c
> index dd12931f3038..add1ece38739 100644
> --- a/drivers/infiniband/core/ucma.c
> +++ b/drivers/infiniband/core/ucma.c
> @@ -1162,16 +1162,20 @@ static ssize_t ucma_accept(struct ucma_file *file=
, const char __user *inbuf,
>=20
> 	if (cmd.conn_param.valid) {
> 		ucma_copy_conn_param(ctx->cm_id, &conn_param, &cmd.conn_param);
> -		mutex_lock(&file->mut);
> 		mutex_lock(&ctx->mutex);
> +		rdma_lock_handler(ctx->cm_id);
> 		ret =3D __rdma_accept_ece(ctx->cm_id, &conn_param, NULL, &ece);
> -		mutex_unlock(&ctx->mutex);
> -		if (!ret)
> +		if (!ret) {
> +			/* The uid must be set atomically with the handler */
> 			ctx->uid =3D cmd.uid;
> -		mutex_unlock(&file->mut);
> +		}
> +		rdma_unlock_handler(ctx->cm_id);
> +		mutex_unlock(&ctx->mutex);
> 	} else {
> 		mutex_lock(&ctx->mutex);
> +		rdma_lock_handler(ctx->cm_id);
> 		ret =3D __rdma_accept_ece(ctx->cm_id, NULL, NULL, &ece);
> +		rdma_unlock_handler(ctx->cm_id);
> 		mutex_unlock(&ctx->mutex);
> 	}
> 	ucma_put_ctx(ctx);
> diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
> index cf5da2ae49bf..c1334c9a7aa8 100644
> --- a/include/rdma/rdma_cm.h
> +++ b/include/rdma/rdma_cm.h
> @@ -253,6 +253,8 @@ int rdma_listen(struct rdma_cm_id *id, int backlog);
> int __rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_par=
am,
> 		  const char *caller);
>=20
> +void rdma_lock_handler(struct rdma_cm_id *id);
> +void rdma_unlock_handler(struct rdma_cm_id *id);
> int __rdma_accept_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn=
_param,
> 		      const char *caller, struct rdma_ucm_ece *ece);
>=20
> @@ -270,6 +272,9 @@ int __rdma_accept_ece(struct rdma_cm_id *id, struct r=
dma_conn_param *conn_param,
>  * In the case of error, a reject message is sent to the remote side and =
the
>  * state of the qp associated with the id is modified to error, such that=
 any
>  * previously posted receive buffers would be flushed.
> + *
> + * This function is for use by kernel ULPs and must be called from under=
 the
> + * handler callback.
>  */
> #define rdma_accept(id, conn_param) \
> 	__rdma_accept((id), (conn_param),  KBUILD_MODNAME)
> --=20
> 2.26.2
>=20

--
Chuck Lever



