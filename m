Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3A8AB4084
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2019 20:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbfIPSp6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Sep 2019 14:45:58 -0400
Received: from mail-eopbgr00079.outbound.protection.outlook.com ([40.107.0.79]:28547
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729997AbfIPSp5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Sep 2019 14:45:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaPIafj2C95QOPTbMuxHPdMPp2QfmyaJgmKcgMPxsOMCTV0O3Ynu+3BT+6CAr6rUE4BdezIQ6so5t0f9571RHpu6cZhpE6t+WNiuZy5qkDJyacuEA65pxU9NHVFXftJH1RO+blNmzK5TM33CoxTUw4r3I3tuTo1WOXx41puBsiUsy3QIAASLnC9pDPfodsRiQ56L5OEDvWPLYE/zKboRwsoamefvMs8ZEmD8VrRDGIga+k5QCny7qfCMlIMmrwnZuCrcWCe7gu1w4uHj0t1gvURha5w5CtsfJomsWNOqBCkuMGezo9X9d6/gk5OQA5lpBeFBsaj5rBUo6Nu0rj37HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTtA1W7EsBBzMcMS6D9nKkdiIjgir341z+FnE1zqVoY=;
 b=ogs1bXCz2Vbw58eiobDzY65tXJQi3mP/x8FzYm2sQzmnaGUSiGP6ohDlHWIQfueRTqg1nCJXIL8Hpe0dBWiJ50F98d3iXaCut4KZua//7nE6iUuqn9oX1cv4zW519asSFp4COSKThcLsU0fRnWo66+Vw0qXe7xI0CJOILUswlJmzAb03Xm6rKYPNNKap/ylbq6iMvwxmI04YBqQ6n3Qsvsst7zaUdfvVEKjenmZJIUOcK+4HGNGuD1NkJINxvaExBkNOBRS9X+Ku6ZUimsaSGluwdR+zuzELTM1tNbfdSGK2t9NLSh/lUDW2FVGsiTnDQ/LVoPt+v9YiWVXgHNMbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTtA1W7EsBBzMcMS6D9nKkdiIjgir341z+FnE1zqVoY=;
 b=gg9K+GuMqW3AtaPvJpeAq90oSu/6CP9BZ75wyyzsMS4/RjCqPFsL0HvDFBn03tBIUQ9KBnDAOW3kHGLOJCDFirtJfMgalENeayJfDCM7de9Zrr0SKQbvxBF88yQnVIGXrRawsY5uIFFIKBINpiOpugBdgQMJu3K0OBCs/N4RPW8=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5087.eurprd05.prod.outlook.com (20.177.52.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Mon, 16 Sep 2019 18:45:48 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 18:45:48 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH 1/4] RDMA/cm: Fix memory leak in cm_add/remove_one
Thread-Topic: [PATCH 1/4] RDMA/cm: Fix memory leak in cm_add/remove_one
Thread-Index: AQHVbF4MGE1or0EOWk+V0Mh+L1Yx/qcupSgA
Date:   Mon, 16 Sep 2019 18:45:48 +0000
Message-ID: <20190916184544.GG2585@mellanox.com>
References: <20190916071154.20383-1-leon@kernel.org>
 <20190916071154.20383-2-leon@kernel.org>
In-Reply-To: <20190916071154.20383-2-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0068.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::45) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.167.223.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ce143b4-7abb-4445-97fe-08d73ad616fa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR05MB5087;
x-ms-traffictypediagnostic: VI1PR05MB5087:|VI1PR05MB5087:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB50870594F7A7BBE414079120CF8C0@VI1PR05MB5087.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(199004)(189003)(64756008)(66476007)(476003)(2616005)(25786009)(6512007)(107886003)(3846002)(6486002)(6246003)(71190400001)(486006)(99286004)(6916009)(305945005)(14444005)(7736002)(66066001)(256004)(71200400001)(6436002)(186003)(1076003)(76176011)(14454004)(386003)(86362001)(229853002)(66946007)(6506007)(53546011)(26005)(36756003)(102836004)(6116002)(5660300002)(66446008)(478600001)(4326008)(81156014)(81166006)(54906003)(8936002)(316002)(53936002)(8676002)(2906002)(11346002)(446003)(33656002)(52116002)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5087;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oXx6WIKaaoYrHY9JExPkUPQGewNkIcCO9jqWmEzqOerrGNuQ4U5lHKBOYHUBtWOGSCCAGeNdiH5bKnGhqmNAVKAOl/6L9mJlLT4W/uDpAg/De77Y3QexykW2L5QnX2awWfs5YaJW0iUwCklfbhjE3zYbE2WfUX0gGPGkFg4EBS2YT+baMtpCfNWigFdQGdN29/IS+GIQXINeu2OqsNWsJlLz6PkpHP1bb1SfN+9mpYIZaezQ4Puenj1y5GtUomZDXzFzaJg5rMmPdnHD8TY05AeIu2aTflAKU5PRrX5A/VLtU3S5zlhS3mTdDfePpuik3VIn96mSRQ+U3haHi73fKeZofWG52Ytba1BLH7ZrJ2AYk0Lksau1WjMUzyxi0VhyqeOgRVUYDzwQWWZlEsoqTu+zBiRprWHmQAiXRRzaOok=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6D5336051635734CB620158A51808350@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce143b4-7abb-4445-97fe-08d73ad616fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 18:45:48.2856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TP5wp5vOuu2Ijntm+Xop+nmfeUWVbKhQmhbT6GQIJ0mJwG47EprrPLK1XGPtWjrv0MvBRgGUwZP48fzn0fzN1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5087
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 16, 2019 at 10:11:51AM +0300, Leon Romanovsky wrote:
> From: Jack Morgenstein <jackm@dev.mellanox.co.il>
>=20
> In the process of moving the debug counters sysfs entries, the commit
> mentioned below eliminated the cm_infiniband sysfs directory.
>=20
> This sysfs directory was tied to the cm_port object allocated in procedur=
e
> cm_add_one().
>=20
> Before the commit below, this cm_port object was freed via a call to
> kobject_put(port->kobj) in procedure cm_remove_port_fs().
>=20
> Since port no longer uses its kobj, kobject_put(port->kobj) was eliminate=
d.
> This, however, meant that kfree was never called for the cm_port buffers.
>=20
> Fix this by adding explicit kfree(port) calls to functions cm_add_one()
> and cm_remove_one().
>=20
> Note: the kfree call in the first chunk below (in the cm_add_one error
> flow) fixes an old, undetected memory leak.
>=20
> Fixes: c87e65cfb97c ("RDMA/cm: Move debug counters to be under relevant I=
B device")
> Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/core/cm.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> index da10e6ccb43c..5920c0085d35 100644
> +++ b/drivers/infiniband/core/cm.c
> @@ -4399,6 +4399,7 @@ static void cm_add_one(struct ib_device *ib_device)
>  error1:
>  	port_modify.set_port_cap_mask =3D 0;
>  	port_modify.clr_port_cap_mask =3D IB_PORT_CM_SUP;
> +	kfree(port);
>  	while (--i) {
>  		if (!rdma_cap_ib_cm(ib_device, i))
>  			continue;
> @@ -4407,6 +4408,7 @@ static void cm_add_one(struct ib_device *ib_device)
>  		ib_modify_port(ib_device, port->port_num, 0, &port_modify);
>  		ib_unregister_mad_agent(port->mad_agent);
>  		cm_remove_port_fs(port);
> +		kfree(port);
>  	}
>  free:
>  	kfree(cm_dev);
> @@ -4460,6 +4462,7 @@ static void cm_remove_one(struct ib_device *ib_devi=
ce, void *client_data)
>  		spin_unlock_irq(&cm.state_lock);
>  		ib_unregister_mad_agent(cur_mad_agent);
>  		cm_remove_port_fs(port);
> +		kfree(port);
>  	}

This whole thing is looking pretty goofy now, and I suspect there are
more error unwind bugs here.

How about this instead:

From e8dad20c7b69436e63b18f16cd9457ea27da5bc1 Mon Sep 17 00:00:00 2001
From: Jack Morgenstein <jackm@dev.mellanox.co.il>
Date: Mon, 16 Sep 2019 10:11:51 +0300
Subject: [PATCH] RDMA/cm: Fix memory leak in cm_add/remove_one

In the process of moving the debug counters sysfs entries, the commit
mentioned below eliminated the cm_infiniband sysfs directory, and created
some missing cases where the port pointers were not being freed as the
kobject_put was also eliminated.

Rework this to not allocate port pointers and consolidate all the error
unwind into one sequence.

This also fixes unlikely racey bugs where error-unwind after unregistering
the MAD handler would miss flushing the WQ and other clean up that is
necessary once concurrency starts.

Fixes: c87e65cfb97c ("RDMA/cm: Move debug counters to be under relevant IB =
device")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/cm.c | 187 ++++++++++++++++++-----------------
 1 file changed, 94 insertions(+), 93 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index da10e6ccb43cd0..30a764e763dec1 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -223,7 +223,7 @@ struct cm_device {
 	struct ib_device *ib_device;
 	u8 ack_delay;
 	int going_down;
-	struct cm_port *port[0];
+	struct cm_port port[];
 };
=20
 struct cm_av {
@@ -520,7 +520,7 @@ get_cm_port_from_path(struct sa_path_rec *path, const s=
truct ib_gid_attr *attr)
 		read_lock_irqsave(&cm.device_lock, flags);
 		list_for_each_entry(cm_dev, &cm.device_list, list) {
 			if (cm_dev->ib_device =3D=3D attr->device) {
-				port =3D cm_dev->port[attr->port_num - 1];
+				port =3D &cm_dev->port[attr->port_num - 1];
 				break;
 			}
 		}
@@ -539,7 +539,7 @@ get_cm_port_from_path(struct sa_path_rec *path, const s=
truct ib_gid_attr *attr)
 					     sa_conv_pathrec_to_gid_type(path),
 					     NULL);
 			if (!IS_ERR(attr)) {
-				port =3D cm_dev->port[attr->port_num - 1];
+				port =3D &cm_dev->port[attr->port_num - 1];
 				break;
 			}
 		}
@@ -4319,23 +4319,99 @@ static void cm_remove_port_fs(struct cm_port *port)
=20
 }
=20
-static void cm_add_one(struct ib_device *ib_device)
+static void cm_destroy_one_port(struct cm_device *cm_dev, unsigned int por=
t_num)
 {
-	struct cm_device *cm_dev;
-	struct cm_port *port;
+	struct cm_port *port =3D &cm_dev->port[port_num - 1];
+	struct ib_port_modify port_modify =3D {
+		.clr_port_cap_mask =3D IB_PORT_CM_SUP
+	};
+	struct ib_mad_agent *cur_mad_agent;
+	struct cm_id_private *cm_id_priv;
+
+	if (!rdma_cap_ib_cm(cm_dev->ib_device, port_num))
+		return;
+
+	ib_modify_port(cm_dev->ib_device, port_num, 0, &port_modify);
+
+	/* Mark all the cm_id's as not valid */
+	spin_lock_irq(&cm.lock);
+	list_for_each_entry (cm_id_priv, &port->cm_priv_altr_list, altr_list)
+		cm_id_priv->altr_send_port_not_ready =3D 1;
+	list_for_each_entry (cm_id_priv, &port->cm_priv_prim_list, prim_list)
+		cm_id_priv->prim_send_port_not_ready =3D 1;
+	spin_unlock_irq(&cm.lock);
+
+	/*
+	 * We flush the queue here after the going_down set, this verifies
+	 * that no new works will be queued in the recv handler, after that we
+	 * can call the unregister_mad_agent
+	 */
+	flush_workqueue(cm.wq);
+
+	spin_lock_irq(&cm.state_lock);
+	cur_mad_agent =3D port->mad_agent;
+	port->mad_agent =3D NULL;
+	spin_unlock_irq(&cm.state_lock);
+
+	if (cur_mad_agent)
+		ib_unregister_mad_agent(cur_mad_agent);
+
+	cm_remove_port_fs(port);
+}
+
+static int cm_init_one_port(struct cm_device *cm_dev, unsigned int port_nu=
m)
+{
+	struct cm_port *port =3D &cm_dev->port[port_num - 1];
 	struct ib_mad_reg_req reg_req =3D {
 		.mgmt_class =3D IB_MGMT_CLASS_CM,
 		.mgmt_class_version =3D IB_CM_CLASS_VERSION,
 	};
 	struct ib_port_modify port_modify =3D {
-		.set_port_cap_mask =3D IB_PORT_CM_SUP
+		.set_port_cap_mask =3D IB_PORT_CM_SUP,
 	};
-	unsigned long flags;
 	int ret;
+
+	if (!rdma_cap_ib_cm(cm_dev->ib_device, port_num))
+		return 0;
+
+	set_bit(IB_MGMT_METHOD_SEND, reg_req.method_mask);
+
+	port->cm_dev =3D cm_dev;
+	port->port_num =3D port_num;
+
+	INIT_LIST_HEAD(&port->cm_priv_prim_list);
+	INIT_LIST_HEAD(&port->cm_priv_altr_list);
+
+	ret =3D cm_create_port_fs(port);
+	if (ret)
+		return ret;
+
+	port->mad_agent =3D
+		ib_register_mad_agent(cm_dev->ib_device, port_num, IB_QPT_GSI,
+				      &reg_req, 0, cm_send_handler,
+				      cm_recv_handler, port, 0);
+	if (IS_ERR(port->mad_agent)) {
+		cm_destroy_one_port(cm_dev, port_num);
+		return PTR_ERR(port->mad_agent);
+	}
+
+	ret =3D ib_modify_port(cm_dev->ib_device, port_num, 0, &port_modify);
+	if (ret) {
+		cm_destroy_one_port(cm_dev, port_num);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void cm_add_one(struct ib_device *ib_device)
+{
+	struct cm_device *cm_dev;
+	unsigned long flags;
 	int count =3D 0;
 	u8 i;
=20
-	cm_dev =3D kzalloc(struct_size(cm_dev, port, ib_device->phys_port_cnt),
+	cm_dev =3D kvzalloc(struct_size(cm_dev, port, ib_device->phys_port_cnt),
 			 GFP_KERNEL);
 	if (!cm_dev)
 		return;
@@ -4344,41 +4420,9 @@ static void cm_add_one(struct ib_device *ib_device)
 	cm_dev->ack_delay =3D ib_device->attrs.local_ca_ack_delay;
 	cm_dev->going_down =3D 0;
=20
-	set_bit(IB_MGMT_METHOD_SEND, reg_req.method_mask);
 	for (i =3D 1; i <=3D ib_device->phys_port_cnt; i++) {
-		if (!rdma_cap_ib_cm(ib_device, i))
-			continue;
-
-		port =3D kzalloc(sizeof *port, GFP_KERNEL);
-		if (!port)
-			goto error1;
-
-		cm_dev->port[i-1] =3D port;
-		port->cm_dev =3D cm_dev;
-		port->port_num =3D i;
-
-		INIT_LIST_HEAD(&port->cm_priv_prim_list);
-		INIT_LIST_HEAD(&port->cm_priv_altr_list);
-
-		ret =3D cm_create_port_fs(port);
-		if (ret)
-			goto error1;
-
-		port->mad_agent =3D ib_register_mad_agent(ib_device, i,
-							IB_QPT_GSI,
-							&reg_req,
-							0,
-							cm_send_handler,
-							cm_recv_handler,
-							port,
-							0);
-		if (IS_ERR(port->mad_agent))
-			goto error2;
-
-		ret =3D ib_modify_port(ib_device, i, 0, &port_modify);
-		if (ret)
-			goto error3;
-
+		if (!cm_init_one_port(cm_dev, i))
+			goto error;
 		count++;
 	}
=20
@@ -4392,35 +4436,16 @@ static void cm_add_one(struct ib_device *ib_device)
 	write_unlock_irqrestore(&cm.device_lock, flags);
 	return;
=20
-error3:
-	ib_unregister_mad_agent(port->mad_agent);
-error2:
-	cm_remove_port_fs(port);
-error1:
-	port_modify.set_port_cap_mask =3D 0;
-	port_modify.clr_port_cap_mask =3D IB_PORT_CM_SUP;
-	while (--i) {
-		if (!rdma_cap_ib_cm(ib_device, i))
-			continue;
-
-		port =3D cm_dev->port[i-1];
-		ib_modify_port(ib_device, port->port_num, 0, &port_modify);
-		ib_unregister_mad_agent(port->mad_agent);
-		cm_remove_port_fs(port);
-	}
+error:
+	while (--i)
+		cm_destroy_one_port(cm_dev, i);
 free:
-	kfree(cm_dev);
+	kvfree(cm_dev);
 }
=20
 static void cm_remove_one(struct ib_device *ib_device, void *client_data)
 {
 	struct cm_device *cm_dev =3D client_data;
-	struct cm_port *port;
-	struct cm_id_private *cm_id_priv;
-	struct ib_mad_agent *cur_mad_agent;
-	struct ib_port_modify port_modify =3D {
-		.clr_port_cap_mask =3D IB_PORT_CM_SUP
-	};
 	unsigned long flags;
 	int i;
=20
@@ -4435,34 +4460,10 @@ static void cm_remove_one(struct ib_device *ib_devi=
ce, void *client_data)
 	cm_dev->going_down =3D 1;
 	spin_unlock_irq(&cm.lock);
=20
-	for (i =3D 1; i <=3D ib_device->phys_port_cnt; i++) {
-		if (!rdma_cap_ib_cm(ib_device, i))
-			continue;
-
-		port =3D cm_dev->port[i-1];
-		ib_modify_port(ib_device, port->port_num, 0, &port_modify);
-		/* Mark all the cm_id's as not valid */
-		spin_lock_irq(&cm.lock);
-		list_for_each_entry(cm_id_priv, &port->cm_priv_altr_list, altr_list)
-			cm_id_priv->altr_send_port_not_ready =3D 1;
-		list_for_each_entry(cm_id_priv, &port->cm_priv_prim_list, prim_list)
-			cm_id_priv->prim_send_port_not_ready =3D 1;
-		spin_unlock_irq(&cm.lock);
-		/*
-		 * We flush the queue here after the going_down set, this
-		 * verify that no new works will be queued in the recv handler,
-		 * after that we can call the unregister_mad_agent
-		 */
-		flush_workqueue(cm.wq);
-		spin_lock_irq(&cm.state_lock);
-		cur_mad_agent =3D port->mad_agent;
-		port->mad_agent =3D NULL;
-		spin_unlock_irq(&cm.state_lock);
-		ib_unregister_mad_agent(cur_mad_agent);
-		cm_remove_port_fs(port);
-	}
+	for (i =3D 1; i <=3D ib_device->phys_port_cnt; i++)
+		cm_destroy_one_port(cm_dev, i);
=20
-	kfree(cm_dev);
+	kvfree(cm_dev);
 }
=20
 static int __init ib_cm_init(void)
--=20
2.23.0

