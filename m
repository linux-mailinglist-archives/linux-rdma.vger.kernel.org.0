Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2E98CEC42
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2019 20:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbfJGS6S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Oct 2019 14:58:18 -0400
Received: from mail-eopbgr60089.outbound.protection.outlook.com ([40.107.6.89]:60800
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728071AbfJGS6S (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Oct 2019 14:58:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4fG7RRxPmGvQgAy8gUQvzKTOdyXb1jv0tQslcYlCrQPPYrcM0+r/PLNIUNwt3ZJAKswLBhU8+8QFYv4DfIknlFLP/4ZkB66aumoF/f9w7m8E4/966du6muGasYWbefXuTpbKX5AMxIi/SnbHl1A5cupqabedlRM5uQYuIWIPkQP1H/IYQEw+MMSjGoCap33nbzTTj2fvlJeobLfHnWABzavdxpwfo4DrB+4Hfxwl5MOTibCWXI96n9M8aPBWHOALyH5NvaPmcPjhuN9vWxxbCUxubf9ENMdx+Brm9fRabROTSG+x59XGHxgsrbtsqiU764dZqK9ENNQPKT1lo0KsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eic2eifAPPS/CGTxBhiCbpn7aSKopaIqKFs8W416VRY=;
 b=cKNmM5io8P6Zon0o711IHhiuP6mPNhZKbo128GrZfIixZhrTnsRsmBWbpSWx6T7sY1yqZLBTQ90tfruYKq1fIIqkm0RvkWjQ3J4519WfLgIKNG6bRNnQEAsg7AtwWWIRD2jJUOURtf7Af/ilTBxEBQ+AISZ/Dy5U1AlGlg9pHOq7pONFI0EV2R/kZ/c7d01MRVTXpDk/6kvZBzEYPPbf1S1rBmnTGcZeE3iD1HKE8AQ1X7vMG75FXW0KNRWGR78/6ZLGom93d9laWk8alaYxEbppN0HSyNq86j5K+6PgOE8andZpu9FakEHWa0k1QsFUFKI8FS99Q5YwApdXssOF8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eic2eifAPPS/CGTxBhiCbpn7aSKopaIqKFs8W416VRY=;
 b=NN5JPWIHFa+xYU6UFdrwAkmKlb/kBqVO+65e6MWcYRK4WoVgJU+NmwbnKNg1C+7cG9rKCnZ/QTPizn+GCG7hY064IDlsc0bZgQf5iSLhYQlTHwYtUQhpuOH4axyQsDwZSjmydRrOQOfCL37yfQOZ/u3JTpKktQyKVOZhZZ0jMns=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB5329.eurprd05.prod.outlook.com (20.178.17.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.23; Mon, 7 Oct 2019 18:58:13 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432%7]) with mapi id 15.20.2327.023; Mon, 7 Oct 2019
 18:58:13 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-next 2/2] RDMA/core: Check that process is still
 alive before sending it to the users
Thread-Topic: [PATCH rdma-next 2/2] RDMA/core: Check that process is still
 alive before sending it to the users
Thread-Index: AQHVeR2KTkqdrwtqSUGNaztNqWaVTKdPjyMg
Date:   Mon, 7 Oct 2019 18:58:13 +0000
Message-ID: <AM0PR05MB4866CB24D8105C83B31988A3D19B0@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <20191002123245.18153-1-leon@kernel.org>
 <20191002123245.18153-3-leon@kernel.org>
In-Reply-To: <20191002123245.18153-3-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0834609f-4ee3-45e5-5554-08d74b584e19
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM0PR05MB5329:|AM0PR05MB5329:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB53295A9871F957D4A600F6A8D19B0@AM0PR05MB5329.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(189003)(199004)(13464003)(6506007)(52536014)(81156014)(81166006)(102836004)(446003)(11346002)(8676002)(476003)(110136005)(76176011)(54906003)(7736002)(66066001)(66946007)(4326008)(6246003)(33656002)(7696005)(66476007)(66556008)(64756008)(66446008)(2906002)(5660300002)(99286004)(76116006)(14454004)(25786009)(6436002)(229853002)(486006)(256004)(9686003)(55016002)(53546011)(74316002)(305945005)(26005)(186003)(6636002)(8936002)(498600001)(86362001)(3846002)(6116002)(71200400001)(71190400001)(26730200005)(19860200003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB5329;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ge9AOkVK40OeDuCmYu7UYlON2og8yr81zq+mKRMW6aN2d8fG6Yn0MesS45LorbqQaRTezYx5epwWZe+F0WPPGecbnpSw89RruzEgojFHP0DxlSKHBvLplcGJJaGdKObAvJ+OkNOVqiRvhhgbUjDmZFuxR1U7OF9t3KUERmzGJ+Dd0BDYx/izkWW8mbZBPys6UIGXB3REbdw/y0y9qX8OcUCo5RXdbHuo823ZF8gzj5vQ9GIyUlRGNFj6RDncnSdbEisOsbY/MO+bQ8pH+893jCpdoUXFiWspFtI3eLa/CkKwHby3LDchGlf6Y83nVbyqw+2Gf9eg3xyyri3QfHPc/XaqAALdTVjBfa78AN8mU/1/aJyfQ/3gAHbH4no35d2tcBZqkiCYyxyKYl17kPvPBJ9l6hebK4HGVDfYUOLgj6c=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0834609f-4ee3-45e5-5554-08d74b584e19
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 18:58:13.4673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aJ4vYSMdteW1Zp3BujYPethAe6NxPcoyHFRk+d3eC3T9ZVwQ/f1H2EJZDK8G2XRL7LJZY/LtBMkHoznLdbwBnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5329
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Leon Romanovsky
> Sent: Wednesday, October 2, 2019 7:33 AM
> To: Doug Ledford <dledford@redhat.com>; Jason Gunthorpe
> <jgg@mellanox.com>
> Cc: Leon Romanovsky <leonro@mellanox.com>; RDMA mailing list <linux-
> rdma@vger.kernel.org>
> Subject: [PATCH rdma-next 2/2] RDMA/core: Check that process is still ali=
ve
> before sending it to the users
>=20
> From: Leon Romanovsky <leonro@mellanox.com>
>=20
> The PID information can disappear asynchronically because task can be kil=
led
> and moved to zombie state. In such case, PID will be zero in similar way =
to the
> kernel tasks. Recognize such situation where we are asking to return orph=
aned
> object and simply skip filling PID attribute.
>=20
> As part of this change, document the same scenario in counter.c code.
>=20
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/counters.c | 14 ++++++++++++--
>  drivers/infiniband/core/nldev.c    | 31 ++++++++++++++++++++++--------
>  2 files changed, 35 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/counters.c
> b/drivers/infiniband/core/counters.c
> index 12ba2685abcf..47c551a0bcb0 100644
> --- a/drivers/infiniband/core/counters.c
> +++ b/drivers/infiniband/core/counters.c
> @@ -149,8 +149,18 @@ static bool auto_mode_match(struct ib_qp *qp, struct
> rdma_counter *counter,
>  	struct auto_mode_param *param =3D &counter->mode.param;
>  	bool match =3D true;
>=20
> -	/* Ensure that counter belongs to the right PID */
> -	if (task_pid_nr(counter->res.task) !=3D task_pid_nr(qp->res.task))
> +	/*
> +	 * Ensure that counter belongs to the right PID.
> +	 * This operation can race with user space which kills
> +	 * the process and leaves QP and counters orphans.
> +	 *
> +	 * It is not a big deal because exitted task will leave both
> +	 * QP and counter in the same bucket of zombie process. Just ensure
> +	 * that process is still alive before procedding.
> +	 *
> +	 */
> +	if (task_pid_nr(counter->res.task) !=3D task_pid_nr(qp->res.task) ||
> +	    !task_pid_nr(qp->res.task))
>  		return false;
>=20
>  	if (auto_mask & RDMA_COUNTER_MASK_QP_TYPE) diff --git
> a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c index
> 71bc08510064..c6fe0c52f6dc 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -399,20 +399,35 @@ static int fill_res_info(struct sk_buff *msg, struc=
t
> ib_device *device)  static int fill_res_name_pid(struct sk_buff *msg,
>  			     struct rdma_restrack_entry *res)  {
> +	int err =3D 0;
> +	pid_t pid;
> +
>  	/*
>  	 * For user resources, user is should read /proc/PID/comm to get the
>  	 * name of the task file.
>  	 */
>  	if (rdma_is_kernel_res(res)) {
> -		if (nla_put_string(msg,
> RDMA_NLDEV_ATTR_RES_KERN_NAME,
> -		    res->kern_name))
> -			return -EMSGSIZE;
> -	} else {
> -		if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PID,
> -		    task_pid_vnr(res->task)))
> -			return -EMSGSIZE;
> +		err =3D nla_put_string(msg,
> RDMA_NLDEV_ATTR_RES_KERN_NAME,
> +				     res->kern_name);
> +		goto out;
>  	}
> -	return 0;
> +
> +	pid =3D task_pid_vnr(res->task);
> +	/*
> +	 * PID =3D=3D 0 returns in two scenarios:
> +	 * 1. It is kernel task, but because we checked above, it won't be
> possible.
Please drop above comment point 1. See more below.

> +	 * 2. Task is dead and in zombie state. There is no need to print PID
> anymore.
> +	 */
> +	if (pid)
> +		/*
> +		 * This part is racy, task can be killed and PID will be zero right
> +		 * here but it is ok, next query won't return PID. We don't
> promise
> +		 * real-time reflection of SW objects.
> +		 */
> +		err =3D nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PID, pid);
> +
> +out:
> +	return err ? -EMSGSIZE : 0;
>  }

Below code reads better along with rest of the comments in the patch.

if (kern_resource) {
	err =3D nla_put_string(msg, RDMA_NLDEV_ATTR_RES_KERN_NAME,
			     res->kern_name);
} else {
	pid_t pid;

	pid =3D task_pid_vnr(res->task);
	if (pid)
		err =3D nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PID, pid);
}

>=20
>  static bool fill_res_entry(struct ib_device *dev, struct sk_buff *msg,
> --
> 2.20.1

