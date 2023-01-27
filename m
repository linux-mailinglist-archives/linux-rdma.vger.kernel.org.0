Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3870067DDF6
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jan 2023 07:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjA0Grj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 27 Jan 2023 01:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjA0GrV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Jan 2023 01:47:21 -0500
Received: from BN3PR00CU001-vft-obe.outbound.protection.outlook.com (mail-eastus2azlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088BF77DD7;
        Thu, 26 Jan 2023 22:44:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nc456AWetRL9jNj/fYZtzzLg3veLkfASgzE5vz6nLNWmilIkVpmBXm5P74RnKYfXZcnmbqDQA3BD5B4kdqaOpJd7Xc3ke8O7jRavGBKTXflT2vB30dFniUpK0lueFvUtx5v+lVKpwit6JuZ9p8N4Ylt7mjuXTCZOnZXZ7JHFRf/K4DHnTA9IUTXfVyBtBw/wgPW94s2jNj8pvTMSvpnM7mgVWYKY84n88eQd4qcbONkVfIaZOZJaqxTz7Zg+6p0N93FBTUJ61h/k+FzCmikihItAWhrkDpOS01O3N3dCzmWCSKsjKqDtE5yciCe+LUIsqHjLHNlR0dmTxWPib4xeeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doODVSMNB7kHngn5f72z9nL7nML1yElvSRLtPcAD3SQ=;
 b=cjaBPvN098ZTOmhUYu0BchRU1aOw07tIw6pvoniRZsXKaqIqzVayi6lLXZNbkU+U1/UHpNZhjDsrJfTp55Wtgl/4N5MN7QKf9vDLweJEJHgjLMYGzdw0J1KFsUHOSLmBzHbtBeygmFjDeIF7Sdv4u7/NrIXikRiPUsA+WHiCQfBK7UPioyrzwLINk1+sVf/a1AoxrKjQEhl5xkMa8RuMkBINq6FsXLiF3xTDyqWwr3f+tcAkBWq+toDzUl0U0LQ0o2f7HrJtsJ4drrwPcec0agjWqN6kLXI/Ab3WYUp0tgkDOCxGmvevj6433LEdaHKHJxJbucNnHs4GZ59tBuVkpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by MWH0PF7EA4ADAAA.namprd21.prod.outlook.com (2603:10b6:30f:fff1:0:1:0:e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.1; Fri, 27 Jan
 2023 06:41:51 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::7388:5f0b:577a:d9e6]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::7388:5f0b:577a:d9e6%7]) with mapi id 15.20.6064.010; Fri, 27 Jan 2023
 06:41:51 +0000
From:   Long Li <longli@microsoft.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Dan Carpenter <error27@gmail.com>
CC:     Ajay Sharma <sharmaajay@microsoft.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] RDMA/mana_ib: Prevent array underflow in
 mana_ib_create_qp_raw()
Thread-Topic: [PATCH] RDMA/mana_ib: Prevent array underflow in
 mana_ib_create_qp_raw()
Thread-Index: AQHZMAd6D83rME9v5k6DPqU5ey3Mu66wfxYAgAALu4CAABXVgIABKqQA
Date:   Fri, 27 Jan 2023 06:41:51 +0000
Message-ID: <PH7PR21MB3263241A29DFFDD72A30B888CECC9@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <Y8/3Vn8qx00kE9Kk@kili> <Y9JThu/RSCGKAnTH@unreal>
 <Y9JdXfJvGhrJeLF7@kadam> <Y9JvrfOezthLscEP@unreal>
In-Reply-To: <Y9JvrfOezthLscEP@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=60551f1e-2e96-471f-a2d4-f180107b46f2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-27T06:07:46Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|MWH0PF7EA4ADAAA:EE_
x-ms-office365-filtering-correlation-id: 17e4da19-abf0-4dc9-0f31-08db00319288
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C7riPyoJp/sOXVthnnJFlI00ZZ13R63NKBiMZvvGQPlSmrO3Q2+1A3rLQlnhjvMmccENmr608Hes1dKjO4Xm+p6wocmrBxitTgoB408rTfL9vOvfuWACXAMKbHIaZ90sEe1ipT8pYZ4yIi1SjyhBEULowggXvKyDKv6euh4h0dgKqLDwEULBzYW3v29+wz3iWOgV4c4Y62UEV4E18AkofB81dRDOZHB7hyNGAjoIBF/VauQPS5+Ld6w7BRZJtDVmcIsrNa9xQmS5cmo8KGnOrFrBerp6jKueHLb4wv+xS2kWtMxH0MBO1QfaQCbbIpk+s9B2tzwAzjSOZm1SK7TFfGaBaWjXEbplOcq91z6p/MP6DC8Yn8EsY31IlkAIN9IHfp6G/nu82D6XYHKhVr2Bm56LktkbwTehzrq+7NsDkbAUvjIo27lgof5fmYeBG5FEw8GsDPmrMK9SZK1/BcrnzRaJ704ez8roVZHaXjrAerxWbSg/aNqQVbWGk3Aw3l/IwbipkIiFHJUgDeGDIziKMU6MH7GBKvc1nxvcQBovWq3SEIjqeNJxPgYFa2nvSMfvq4ZOWtd0XT6SK9UiLideedAeFzSJPdidgNlZieBfwjeqvdrjMTPYVgqROux9ID+mJ4JxTAK+UXhNIyKgjWSXhiA2o0jxU5LkXtJnYa+P6r9p77avZ/PLYqlP5RHwmGVFZOeVt1cLW0Cc/rxjTulBNoGQVvcgqLB3AEjLgA4/cGxZ+aYlY0Cs5BQ9HrtO+A38otaNqjSpBMKXZvjfqeAHcpz5VOa324OJjmuC6SpptHpSgTp8i3A+QaJ4sRcVDTMg5AFLBH05U14ZO6Bd7m1vVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199018)(2906002)(83380400001)(8990500004)(8936002)(33656002)(82950400001)(478600001)(5660300002)(122000001)(41300700001)(86362001)(4326008)(82960400001)(110136005)(52536014)(9686003)(55016003)(38100700002)(26005)(66556008)(76116006)(64756008)(71200400001)(66946007)(66476007)(316002)(66446008)(7696005)(8676002)(10290500003)(38070700005)(186003)(6506007)(54906003)(12290500018)(15398625002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TCyYd8topcKMurDyG2MkuvOyeywJG3HxySdugdiLp0nLYzNZITjkn6pheOmL?=
 =?us-ascii?Q?0/5LroYWWBrrFu+YP8Lg1mmN5wYuHAkQMnKZynw99Xgqv07XhpdG14hWikBt?=
 =?us-ascii?Q?AUUBFtHUAO8EsXy41Pz/0KoBXnDssvwoGaTIbb3KrFqYxjNFe+BSD5siA0xl?=
 =?us-ascii?Q?9FMzucxtwGSrMAlgy/klZm+ApWjEJTTHHwz/AEUZdyOKBZPyGfgrudFTmPBD?=
 =?us-ascii?Q?EmrcNtV8mMdoYrH9LgAnKoQ9C3HwEANd4XY2XtpztXZhwYuw5LWDDUldlG9M?=
 =?us-ascii?Q?cyJTpLoTMvnq0DS0yy3/OSmUfDrmcYLVk/pveBvKbvzIPxb6scHIRLUZB3JG?=
 =?us-ascii?Q?hXp0TdyOwuQzEQq8xaPDojK3QKG6bEKIl3rA2Ns732mPbQHWpsqc8YaIDl23?=
 =?us-ascii?Q?/eLxG9lrRJMls6ZBXw2JBxZSj47FT0LapJBNLhHoLf0ps4ljyp9BTvAgOeO1?=
 =?us-ascii?Q?hKc4ErCeonPuvi8IuwpxGs9IHsIaCGznzpkXdYhwCGYjY0FIjFUpu785gSmZ?=
 =?us-ascii?Q?6CGHHPmKsUKV5LlBHxkaGJ/idDTQzlLDkKfz+6gtEEwH0/6mS0mc2pX96p5E?=
 =?us-ascii?Q?NSGu0fK5WFcPDw+HtLK44JAbAQhRloUzJG3OSuPxIhmqBnlZNXrx0S+nkVLr?=
 =?us-ascii?Q?wQjmzR6oNCd6VU/kWGfEZrFm4HuzCEf9ijpqdxINcFFPZgMhbgwBRZuF9v3y?=
 =?us-ascii?Q?AZvrQTEqAYOKtEzcTc9T+Is8tE7lwh+0pprWlOLf5uBkimYMAm9Id+nvcSn0?=
 =?us-ascii?Q?1RvzL1H7AIrumee5t9rYp4xeyasqjfOXXaYIHkCZJUkM/7bNNmuaVfUqTWee?=
 =?us-ascii?Q?xTwtptXBGZlKvRtx7vraWcL86MtDY6Nu/t67balXFzGWsgXsjcuK6oBUFr65?=
 =?us-ascii?Q?DTv1x5A+zAYOBTfUSYTRIyV6/AByj0HjonqO72pzy1kQYHm4uE1p1Xhp/iJf?=
 =?us-ascii?Q?r1u6VBGMyKhLmwq5kPRxW9KnHNpUSxEa9x6IYPizA4zcdHYo/QgmDckJPm+a?=
 =?us-ascii?Q?rh7vgm366eeffeLsvG7U0F7lSXbLupyBNR9OVADUmM6N/KkJ46md8nFvQvBL?=
 =?us-ascii?Q?Clqt7BavQxWfBQ5Bw6Ge6tXVFuV+NlS9zTIyNA+U4l1z60bP0RPTMf50XEOx?=
 =?us-ascii?Q?ZaGyoTtvsqSR0I8I9OCPZiJgH0/lUU+M77uOpJGUs3MDTfQwGYDVpNggFlwI?=
 =?us-ascii?Q?UIDfUYL1QZfKvhxB6GV46XDwC9mj1+pIV9qDrQ0Brd0SzKO0XMtOTjD0VK2t?=
 =?us-ascii?Q?yCTJpnPmQC1qGHuRXnrvVdw5SG9LEncNbaGHqb1P28c4UQMUkbKn1p1IhaiQ?=
 =?us-ascii?Q?LyHPl9hluiihahSqsc6Y+F5CREtJ6JB4upUsFQu8UgSv/y9BKCUaGKhMT7GD?=
 =?us-ascii?Q?gVjDkAl6v5ix6D1fHYXz6aS2zsDLsMAfIVVUD50oTCxFdfAPnqwJl16DotnY?=
 =?us-ascii?Q?IiwJYB4RY9rufKB2Wx4Unii7REh+3QDMpwjsGDdVyT93wHfYnnCkMExpReKO?=
 =?us-ascii?Q?ghhdcpNyk6V9o6YmsYmIf8XvSSSDOJb4xF1JsDmq+XSydprYgLHwIudjrfkV?=
 =?us-ascii?Q?GpJ9dnCgb9Nn/WGou5ae9c4eNjNI7JX5HfmGA3KG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e4da19-abf0-4dc9-0f31-08db00319288
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2023 06:41:51.4688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GFWrnGdb31PSC5WdES5GV5etTnNGPONdg17Oytl4rcpdmItlqW/tX3FA8JHzUGOFCAHURsD3LZxJuItVv3mEMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWH0PF7EA4ADAAA
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: Re: [PATCH] RDMA/mana_ib: Prevent array underflow in
> mana_ib_create_qp_raw()
> 
> On Thu, Jan 26, 2023 at 02:00:45PM +0300, Dan Carpenter wrote:
> > On Thu, Jan 26, 2023 at 12:18:46PM +0200, Leon Romanovsky wrote:
> > > On Tue, Jan 24, 2023 at 06:20:54PM +0300, Dan Carpenter wrote:
> > > > The "port" comes from the user and if it is zero then the:
> > > >
> > > > 	ndev = mc->ports[port - 1];
> > > >
> > > > assignment does an out of bounds read.  I have changed the if
> > > > statement to fix this and to mirror how it is done in
> > > > mana_ib_create_qp_rss().
> > > >
> > > > Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft
> > > > Azure Network Adapter")
> > > > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > > > ---
> > > >  drivers/infiniband/hw/mana/qp.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/infiniband/hw/mana/qp.c
> > > > b/drivers/infiniband/hw/mana/qp.c index ea15ec77e321..54b61930a7fd
> > > > 100644
> > > > --- a/drivers/infiniband/hw/mana/qp.c
> > > > +++ b/drivers/infiniband/hw/mana/qp.c
> > > > @@ -289,7 +289,7 @@ static int mana_ib_create_qp_raw(struct ib_qp
> > > > *ibqp, struct ib_pd *ibpd,
> > > >
> > > >  	/* IB ports start with 1, MANA Ethernet ports start with 0 */
> > > >  	port = ucmd.port;
> > > > -	if (ucmd.port > mc->num_ports)
> > > > +	if (port < 1 || port > mc->num_ports)
> > >
> > > Why do I see port in mana_ib_create_qp? It should come from ib_qp_init_attr.
> >
> > I am so confused by this question.  Are you asking me?
> 
> I asked *@microsoft folks.
> 
> > This is the _raw function.
> 
> _raw comes from QP type, it is not raw (basic) in a sense you imagine.
> 
> > I'm now sure what mana_ib_create_qp() has to do with it.
> 
> All create QP calls come through same verbs interface.
> ib_create_qp_user->create_qp->.create_qp->mana_ib_create_qp-
> >mana_ib_create_qp_raw

MANA requires passing a port number when creating a RAW QP on a RDMA(Ethernet) port.
At the hardware layer, the RDMA port and ethernet port share the same hardware resources, 
the port number needs to be known in advance when QP is created. If we don't' specify the port,
the QP needs to take all the ports on the MANA device, some of them may have been assigned to
Ethernet usage and can't be used for RDMA.

The reason is that unlike Nvidia CX hardware, MANA doesn't support bifurcation (for RAW QP) at the hardware level.
[https://www.dpdk.org/wp-content/uploads/sites/35/2018/06/Mellanox-bifurcated-driver-model.pdf]
To support RAW QP on a hardware port, we need to know the port number before configuring it on the hardware.
And Ethernet can't use this port if a RAW QP is created on it. The coordination needs to be done in software.

In production environment, there are multiple ports on the same MANA device assigned to a VM. Customer can
configure some of the ports for Ethernet and some for RDMA/DPDK.

I have investigated using the port_num in struct ib_qp_init_attr, but it seems it can't be used for this purpose
because the port needs to be specified by the user-mode.

Thanks,
Long

> 
> >
> > The port comes from ib_copy_from_udata() which is just a wrapper
> > around copy_from_user().
> 
> Right, and it shouldn't.
> 
> >
> > regards,
> > dan carpenter
> >
