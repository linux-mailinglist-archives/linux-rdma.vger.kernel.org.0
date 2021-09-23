Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF7C415E2C
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Sep 2021 14:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240828AbhIWMUV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Sep 2021 08:20:21 -0400
Received: from mail-mw2nam12on2097.outbound.protection.outlook.com ([40.107.244.97]:13408
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240954AbhIWMUV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Sep 2021 08:20:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAFFtKB95ZKRg72uO13PcxU6xAwAOZP5rVA6h4wpU0o2Fw+xwm5KB6fvuSdrY6ph6+a1hlMIUm57Ha4SkkT1VhHAnDZMb+fy+EFMFQYKPDge4kSjE8aGKIaq4zzXV5RQZwthiwK35B6AhGk+FB4ywHLbH3qnxsX3N83g1QnodQ+WjW0TcXwLG1RkaNQvaRUl850qZQ9cZEicD3GngkckB0i+rwGhadYNuHPFpzMujzVRXjVr+2I9B5Rd3KwdRxzs2Vk78zmO6O0TgyWVzZxwIxkSG3lfpbafNgm610UlMx4khYsBVYmyavmeTES/RKa4F7ULEI9WUm4vSHBq5HeT4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=TU28VFZoKe4tnYvQbMCOtzESxA6pRsdt9FuicRYIxnw=;
 b=DWlWkJlOZ4fPtQjQPRZoSj/bMdwNx2CljLbwdvaHC1rw7tHoeS1hNxiFQG2LnaYypRfpYWeOdxE7QiR9XKPHi7AFlvWZDSvTM5M/f9Pbpf3Jg9uPL0ewgXnO5+kS+1UKqrWpJzWORt/PJIWebD0WJNhp/dPLjJ+gJJD0Q9OhcJSHwhdJh1lxamFJwLtz1vWRk1v9PkQY43eTn14aUyRdOb9E1/p08DlIanLehAoQEiL0YzKRJDFluobn0oLM9x8uAb1a2FE4qUR3WuaX4j2gYoncHRkgmsYChlOMICKKLLs2RCve5gOE9agWQ5J41vAwff/gJpt2A9DD8HvJBSAB6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TU28VFZoKe4tnYvQbMCOtzESxA6pRsdt9FuicRYIxnw=;
 b=jHUbebchhXLBk5EtVgpxcd80jOk8MQh7DvFSf/N2JqRdaQH8Swlm9u8B8y8afuK1/i9Mpt+842LiMWpsaqYf/I4XiedqYoJdEKOYJXcnXqfE9IhsfY1Ym7wC0LarVDISFoQrNhzOE9NJL8ZSvSwLmSu1uEuztxD7P703HcMfXVScftn8sHl9VyeCigUS9lQ+f4F1oM79CxbLoDuTJANOoriLtFfq/Zi6NczgJdKBj8XbPxrxBqsIYgwcRxk1E5YdRJ3XcTWaP7WZxLcs1Lgke9Sf179vpp0AwlWNdfH7UNezM0bOuYD3wx0yFbfAKput9v59+gvs2+3JPfbWG/i9eQ==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH2PR01MB6055.prod.exchangelabs.com (2603:10b6:610:46::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Thu, 23 Sep 2021 12:18:46 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::30a8:19a9:b5c7:96cd]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::30a8:19a9:b5c7:96cd%9]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 12:18:46 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Guo Zhi <qtxuning1999@sjtu.edu.cn>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
Thread-Topic: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
Thread-Index: AQHXr7imk55risfKAUmS2+aCDTMROauwTzmggAAKPwCAANRigIAAR+NggAALsYCAAAjmwA==
Date:   Thu, 23 Sep 2021 12:18:46 +0000
Message-ID: <CH0PR01MB71536B15C0911AFDE910E559F2A39@CH0PR01MB7153.prod.exchangelabs.com>
References: <20210922134857.619602-1-qtxuning1999@sjtu.edu.cn>
 <CH0PR01MB71536ECA05AA44C4FAD83502F2A29@CH0PR01MB7153.prod.exchangelabs.com>
 <276b9343-c23d-ac15-bb73-d7b42e7e7f0f@acm.org> <YUwin2cn8X5GGjyY@unreal>
 <CH0PR01MB7153E7BD0F3CFBA384EF97ACF2A39@CH0PR01MB7153.prod.exchangelabs.com>
 <YUxou5tFS5zcVAsV@unreal>
In-Reply-To: <YUxou5tFS5zcVAsV@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8c3e43b-0d5a-44e1-55f6-08d97e8c4af1
x-ms-traffictypediagnostic: CH2PR01MB6055:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR01MB60552481E8BDAE81C5C51444F2A39@CH2PR01MB6055.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rkWVXSLctRcjel/M4RwGpkJk1oTwkJHPEnk9IHnHx2psVyEd0ITjEvaJU41l2u+gXooxpsWqF1mwEXh4WzPyjTW+V2A5qUeqlXJC1a8exaKAu6pIgB7dQd6ggC4P+6O8xEcGpVMV8S+rrmjna/YgiU8BQNWSzDR9FbCviSjj/iTGbz8qEKG1dzGyLYvd1chivIZ3yJG+GtVIQ+3WqIsowvPEHQLZVgcMLM1Ydxysz/52c59UUCEKRx1BUcqOaG3YfmOsF5i55ezhJS8W2fqAogVVTovCRtT2vK5GCKPKTFrUdvaBykUOnxjqTB1frR+dG26k5dNLLBv+f8B6klx1vlGbsEMKrLVpCkFFfU07LwZH9/oVj9mLTjX4bLZjv+2cI6v7rGryDaxIfgHW0zvse8mUY5pGr8qu14NQy0jNr3RJp476sa3Vy96m5N0eghG+Q2oFnkcX0gb9jEKvO4ifOt2nlO1eTw1Cws4KFWsW7tWvxjpNiwPY7DPEFSHb3HusHetNtr0fGCFepGFHIlH/L85/Z8IDx3QQ1Eyva4VnOATVXK5Yqo5kLa/YQ0K6zcMA984JZALELrDsVHHZAJUHt66DWNpC9VhKM91EZMiSFUU1uBElKJNYUgBf99TNcmGk/AiBXs61T7zjA2O0xHY52Ak/LkWuZ6zJrGF62yHpK3HHYbmj/A5rctEwHbp6NgXGz4dZ8WoEawI1WV96UutnLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(39840400004)(366004)(54906003)(2906002)(8936002)(76116006)(55016002)(4326008)(66476007)(66446008)(9686003)(66946007)(122000001)(4744005)(71200400001)(64756008)(38100700002)(5660300002)(52536014)(66556008)(316002)(8676002)(33656002)(508600001)(38070700005)(6916009)(7696005)(26005)(186003)(6506007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KaZaQsbdJuo7kR4zQdj3SonCJDOw9GcYlgeOeRRUMA2i4CBcCSpTrwgVNQHc?=
 =?us-ascii?Q?aeI+ePnEZl4ldY2kYza6+Q5z1nZrfPMyBh2NQwy6kQ83uvng2FHlG44icCx7?=
 =?us-ascii?Q?xuf5igX0pNqCxQFOjuvRt3cD8iyghvfxI+r5di/33Vdqz9qfDjnRqLMj7ejr?=
 =?us-ascii?Q?ne5xq5jQOCRfgVy5lvWzY8M7lWGIMJOwQXKoPeNHxHvzBjYTSBAtmbRdqFvd?=
 =?us-ascii?Q?MESvVfP5GEsQMApcEYPqQCbPdivNKQHMdjsL/ge5ziswpOG40IQXtESWDt+u?=
 =?us-ascii?Q?xF1m6r2JXTP1Dd356bdfuMe8yIYvWL/S2gJ6g3Vfm7z7kVfbSPr5vcJenlV9?=
 =?us-ascii?Q?Uvk6GpLbVOPEb65YjTUfXuT2qXwIcm+nrgyPygvF3X85zQEk8QDPSZG2+gSB?=
 =?us-ascii?Q?gIoyvPNgU5yGgMGLEr67x8++LR5vU2zmtiHHciUtdQDM6sAjep3Ood+jqlJk?=
 =?us-ascii?Q?lpkCuC7YTmq3uKgaHbkr4MLgyIiu1nxNCXeou9oUmlxa5UkmCXSpQsCw8Nr+?=
 =?us-ascii?Q?pwgI2/S2Vjm2QoWL77fnOkn3TFxgQqyio371kSzsb4AXIfBrysH7WdxYZDAR?=
 =?us-ascii?Q?NSW59OO2eTkNMFeVCk/YFy1SOEFc58CiAQXdfAKyn7WybpTu7oBKVCIX2jTC?=
 =?us-ascii?Q?caCwyf59oozxGolkhk77ix8ngrgPdbzhzYHaZvzbXTR+sbsp2UnKZx7YVk7i?=
 =?us-ascii?Q?frX/l6CLpV4lq8aMMXE5O6j9XDsljmqqHyQLHXaE4m+Qx0LUj9OFpTRlPSw/?=
 =?us-ascii?Q?Do4nswZrOqnsUI9SKsT7e6n9Mdb9AdFI6KWn8EweOaka0JFN62X2vPKMuwrr?=
 =?us-ascii?Q?Ksv5dbMTay/W8o0fSbRpEg+vd7ac/h8lJmQC63GUHZRLuvNnxj4Fp4k3n4XY?=
 =?us-ascii?Q?Zxwwrlw64mMBJ1YldMXdbc4kcjlvqU63ZtOzRvNjJNPymsqg56uRclV03coP?=
 =?us-ascii?Q?igNbRN3Frg8u9gmisl1HM1RjSF+mVQfQxiPQSaNV9RCnkVwJk4GnIJmeGcJu?=
 =?us-ascii?Q?Vr7KMmqd3JBm/OlPrC7Ut6XXuijpQSDWVx1zDkgAYKOwDGwGN1tBselcQw4l?=
 =?us-ascii?Q?D7g8wesKgBjbvmdLkJLNVJcwC/mfjWbb96gqn7NDFmKCd9jZB0Yk1L7RUID1?=
 =?us-ascii?Q?vYQKLmseBAEjjdPsnXOXSybN3bvJ15kcUqS+Y5FOhEbkPENXbGaUp3ypiVFk?=
 =?us-ascii?Q?4BHxvGea6MXMBWsxEizUGjJRWnFwszbVe2aZi64nfAcWZ4vR4/QnEs/5wtGc?=
 =?us-ascii?Q?ND4gfeMXFmNy/0zry+qLvOG0TOP6ckc9WJnhHPqhgfzwYdtg53BYvvvi658B?=
 =?us-ascii?Q?LzY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c3e43b-0d5a-44e1-55f6-08d97e8c4af1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 12:18:46.6421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nq94pYNhidxS+eSaDsZv9huMD3KOA6cbiSuvKsdovYnhXbERQ64q4Iyz6EUgVevdMgRYli3i7b0/w3/IztZAe8ZrqedXzvKAHioFF9vBJrSk7gmdjjnePGwTZl5JDZNv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB6055
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> > >
> >
> > It doesn't look like that works in irqs, softirqs.
>=20
> Are you certain about it?
>=20
> That sysctl is supposed to control the output of %p, nothing more.
>=20

Actually I think is controls %pK.

The code here is what I was referring to.

		/*
		 * kptr_restrict=3D=3D1 cannot be used in IRQ context
		 * because its test for CAP_SYSLOG would be meaningless.
		 */
		if (in_irq() || in_serving_softirq() || in_nmi()) {
			if (spec.field_width =3D=3D -1)
				spec.field_width =3D 2 * sizeof(ptr);
			return error_string(buf, end, "pK-error", spec);
		}

Mike


