Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B29566A747
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Jan 2023 00:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjAMX5i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Jan 2023 18:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAMX5h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Jan 2023 18:57:37 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3387466F
        for <linux-rdma@vger.kernel.org>; Fri, 13 Jan 2023 15:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673654256; x=1705190256;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M7BNeHewmqgWc/vInEE7fQokO+KNLKLnxfPB1doR/tw=;
  b=F4QD8scFEg3Tshc3WdSle5NfMolf0yCfLjfxELk/j0/MYrH8ZvDjTqC1
   51D8pPR3bfXTDfsZv+mEeohaUVhxD6p5QeNT0H9o2dwUSdFE35qQPCFnI
   Z6JVSYzVXJguDomK/ll9udNFb5qgNuTr33JaLJv3CtC+JNqBa/s8k+a5q
   1J6FlASDU1J8eKMVFPO9kUQTwV8nlyIsu78r5h+1P5HuzirSAVzPwU4xP
   Fo5/Z7lq2+EmuQJ61v8HZtdE/zklEQe9fm1VCusjdn2bKEWDZByoA9Grx
   uFEw5EXHDsscadPoi6tC2t0Udju+fWSf6dnCY7LmGMcZorDX1NoEFS9Tg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="311980700"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="311980700"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 15:57:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="651693263"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="651693263"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 13 Jan 2023 15:57:35 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 13 Jan 2023 15:57:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 13 Jan 2023 15:57:34 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 13 Jan 2023 15:57:34 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 13 Jan 2023 15:57:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rr4lilrbmzSCGub7LXGc2qtMkGjx6919VTJMf0BRgJEX2iEaOmUDznUvrjVHR86EkV7fL0NutdjCp/+xwNz0US7lRnYD0zBoRAUbHUqG6fuCjPe59V/5E+RGWMFFPJ9i3QlI+H8FveGoAxfuw8SaNLMQpGdFnt85uzX3RszgQd1uOOtRiorFpnOIrAiXGpPvvZHT1iDDTkg1IJzUmT56UyxmCc3zBJeXP+xwgicjDKzGNMBYiw5dJFvZ8hY+mDwpZSx3sRIQyj+f7b0vFBju+gum/h1ACVGlFzUta/V5YLuu+rlWTd4DBSrWQlBhBqKLbmXdHwBvMagjwuAVtdXI9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uU2yRb7LCKOU4Qpr62CiJ28mzF/TMn66bVGueOcC0cY=;
 b=A1PfiCgSBjG7JIJfxsga5UE3ssunx+6LMtoDuX7kkNqFHkjdA48jxl7lqpzJm8sXp1TMz4cyRLWRG8UgbkT7B/0FnFCXLz7RA+UbPXFsF/0aAEgXPyrG/R37evs1akitZmNB9CALvIaJa8l5SRQjJfB34/6zI/QfIr2s6n4zG38Esfsb1BkP14IIU+RKDSHIovo0FciPVGj1UPtj4jWaScXXZjaH/Hh86jfcwcRA+ywWzG82KCYneGqHIJXKRiA6yElhkWPcgN1P2Xo+UGv1sBpHdeRC7IP3xnpu3p+OAOvQCZn7vUKwK5rPe7yIxRRueJxZ+OuD38V0oDUPoRX8Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by SJ0PR11MB5133.namprd11.prod.outlook.com (2603:10b6:a03:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 23:57:33 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::61f7:7850:6203:bf55]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::61f7:7850:6203:bf55%4]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 23:57:33 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>,
        "Hefty, Sean" <sean.hefty@intel.com>,
        "Rimmer, Todd" <todd.rimmer@intel.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
 rules
Thread-Topic: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
 rules
Thread-Index: AQHXmDZjOykQbRhbB0OylwgVwYR9l6uBQpMAgA+prJCAAATrgIAcjKoAgAA+ygCAJXODQIAASCMAglozZJCAC6bcAIBmzhEQ
Date:   Fri, 13 Jan 2023 23:57:33 +0000
Message-ID: <MWHPR11MB002952D469591FEF43EBC6F6E9C29@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <20210823154816.2027-1-tatyana.e.nikolova@intel.com>
 <20210823161116.GO1721383@nvidia.com>
 <DM6PR11MB46922D3AE92E34B4E1D3AC9FCBCE9@DM6PR11MB4692.namprd11.prod.outlook.com>
 <20210902154003.GW1721383@nvidia.com>
 <DM6PR11MB4692517FBBC9AFD046990DCDCBA09@DM6PR11MB4692.namprd11.prod.outlook.com>
 <20210920232330.GH327412@nvidia.com>
 <DM6PR11MB4692B56B4C7D1E790B50888DCBB89@DM6PR11MB4692.namprd11.prod.outlook.com>
 <20211014233644.GA2744544@nvidia.com>
 <DM6PR11MB4692B502C54F459A2EF9E79CCB399@DM6PR11MB4692.namprd11.prod.outlook.com>
 <Y2uu4HfKADHiCzGx@nvidia.com>
In-Reply-To: <Y2uu4HfKADHiCzGx@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0029:EE_|SJ0PR11MB5133:EE_
x-ms-office365-filtering-correlation-id: 92234d96-b654-4a20-3540-08daf5c1f01e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EBVn8oNOPEtTipXiyKdAU0TbOZDB6IZKbPumvFUEDrOdTTIa7tjj7vGSkYL4AbT1crudc8UKXv1TD/Q2XW++vzXuUfizgbVOHmbw2OD7Muf2bkBZk5ap7zD4W0TBssqm25l6v2WG9Be/yeFYTAZZBHhzpHZdT+GSpL+AFgTKLQbOraqoh6R8pjEkvfLE0pK6Q2lvqZ50YY0uQbzvmutIhRFd1K/xHDenGU5T3o++X04/NyzTA212fhH6uDaIVW6JrLcAu7e5baK7lmMPuDHxWomilfU6+7MCYpCujGUAwG7PDIn3KwQdH8Wvcng4LN03suahykYz5diY1pYo8cuqbxOjawyt4RwNpWW3DySYv0VjUh1YW9ZhIyUphPjganA0j8XHl5qbvzCfjIFeTco8tMcN3U5nuQxKBsCbvGnPLsghtF6pdnbCY+GYcamp1BTWYZcJUErHAw58m7goNI6PGPVb8xmo9SmPECmlTzDXXoq3rZ20PMWq0nxgA/8lgSwG6K26FdpzArHxbvU0XUJsrpc7DtVVPEKWyeojoCjDnCN76CMJZASBMwee3buzSu0zGFwQdqgOiPQGUZVkL/3pdeSKhjfgznmjXC4lTmYkCctkoOn7QPLVM1/CP2tKNLSMQgiDvj1ahO9qtqF9kHFu3lPigmu4Sica5vV/zKK+XUYp2EEvUKENK0soFJHcOJ0jO++8xo4LRMtcGhN6TCQtSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199015)(6506007)(2906002)(76116006)(5660300002)(52536014)(8936002)(122000001)(8676002)(4326008)(64756008)(66446008)(9686003)(38100700002)(33656002)(82960400001)(41300700001)(38070700005)(478600001)(66946007)(186003)(66556008)(55016003)(7696005)(66476007)(26005)(86362001)(71200400001)(316002)(6636002)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9Lqzy1coMxl7HjFSME2NNkUrmeH0iL68DgnvnpRNbLf7cBxMrSGRLicJiJAn?=
 =?us-ascii?Q?tv3m+O/UyE8xOs2gyKox1oGPMGpNKu95wxRyMniQXOQ0lvQdh2CXDuexpdkb?=
 =?us-ascii?Q?qQu+tzB5LZTHoZl5i+n7ty4lPhGljRjn7CuEZjdkZOczjplHaIgrDhaZwz/w?=
 =?us-ascii?Q?miSf3xo+mWyTtDgA2t0MsF5+q8dkdNuZH/w0AZjl//7SNrFg1qAcMWvY/n49?=
 =?us-ascii?Q?RM8XbwnKAC521MCva1IrayjSIdZUbXHhTDActZj8WB7cHL5OLdDrWdGgt95B?=
 =?us-ascii?Q?SNODHPuK9SaqOk805SJQZ2qJVofco/NIE8rGp2T/3hYl81W/dhymfo/7btkJ?=
 =?us-ascii?Q?hnAQmvVc0xE1a6Cw/qLOEgyEtSN8FOa7Sk4mBeeabNx0KTLl/F5sL7yIox2o?=
 =?us-ascii?Q?blHZN3ag72scytXpFFr4QYD4UsSSYu6YRYO6R438/x0vFLKuKNq8EX3qxVdF?=
 =?us-ascii?Q?iv0rFKq5TkaXjpds45eqFWidoP0r4htLI0Vz5R20zPX76pP2TcAQcQdKG3DW?=
 =?us-ascii?Q?GyeF8NXhLXr6YhiHNmoVBXT5EP03z/7TRh25uOA3WiT4XzmBfPQEra/PILAX?=
 =?us-ascii?Q?uHii6i4AxJMbkW83Qswh5SlAlBVkZW8BV+oaxB7kVcdFrNTxyrsYByt9PAKK?=
 =?us-ascii?Q?eW2jCOpU8P8PHb6vZvd3JJTIuOllzocS34VLREqACsCW95p4xAYSsXw0cq0s?=
 =?us-ascii?Q?AeOcMVCTzxU3bPkwrSUTJqnHvVgMwCPNILFH/NVPcilOr433j0IwE4ulMD1y?=
 =?us-ascii?Q?YXGdL73BLFRD4RldZ8pImgFteE6drQy0dz9f6mCN45dGB0YaIL2y3oXDjM1J?=
 =?us-ascii?Q?+s2/AqSEKFyXAqDJTG0BnIK3BQbaVLw33zHPZlkpeChAjljXPqaRo4zVUNnV?=
 =?us-ascii?Q?ToKWIzNiQbhGmsZQfa78/dhPvYvuY+Hwh0c0XGVBtvndTsMT+hWakukl6rjU?=
 =?us-ascii?Q?q9vT6SNDEH1VPgr6WXlzZpN3vqjz8dq+ll4o7ow++Ap4yxAjKKiCn5oM2ewA?=
 =?us-ascii?Q?GTxfhIh42nyxdKTX00Qo8p3EJmJNL7hhZDsc0K8/t/pMAvGa3U9VSsixEotj?=
 =?us-ascii?Q?Z1KqnvJ8Jro8Zfb+4MVpRLP/OYqm+CqSKrtUZV3OcdNyFiRFrW5HDolMcFH8?=
 =?us-ascii?Q?yAd1GtWh8EqYXP4lwnqk6rYJxiQ92MlwrcyUP9Ruwc60rm5pRWRjh+86L8v9?=
 =?us-ascii?Q?2f7LcNfYmSx78Z05DjfUQZ83xCKNOQy9cnC3zeqnilhBr0GQu683lPu/eafX?=
 =?us-ascii?Q?1tejRHb7YMcepzx9fUKxdszY2Ih4uEr6dQUJKoy6h/IBBRylKLHRAvEFwMTE?=
 =?us-ascii?Q?6Jjxfc5CqfDDT4kvSeGSm279EdFZ51Wc9L1WvhiymYSCcXaeBptgX8Ma4NRZ?=
 =?us-ascii?Q?L+xrdeUsKJPRoOlERlUeKC4k25lscuTZcNUVA3olGS5LN1bwBVD2+u+QpqFM?=
 =?us-ascii?Q?1JEsKjb5xavQ/2IexkHSYuBR2KbpVVXu8VQ2+zivOgUqQydY+SNvl91Of39v?=
 =?us-ascii?Q?4J3xnrkVCPN9xyD/1T0z+bMf+8FESSA3FE+vhlwWRZXTWe7+gwXztxDUJA92?=
 =?us-ascii?Q?cKKgy0Y+6nHvbHxI+DaP8r4hxjeCWWFzyYYPmvQn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92234d96-b654-4a20-3540-08daf5c1f01e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 23:57:33.2038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VD9atC4+BTMUVCiOzD09W0smOkE7auSTli3rMJQIw+BRTgU7OadEUI/rD4J1D8XcqZkwOFd7Tns+umotSSaI+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5133
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: Re: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot=
 rules
>=20
> On Wed, Nov 02, 2022 at 04:40:20PM +0000, Nikolova, Tatyana E wrote:
> > Hi Jason,
> >
> > I know it has been a while since we discussed this. Based on your feedb=
ack, we
> are proposing another solution for the irdma kernel-boot rules. Could you=
 please
> review it?
> >
> > > > udevadm info --attribute-walk /sys/class/infiniband/rocep47s0f0
> > > >
> > > >   looking at device
> > > '/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/infiniband/rocep47s0f0=
':
> > >
> > > This looks like the problem. For any of this to work the infiniband
> > > device needs to be parented to the aux device, not the PCI device.
> > >
> > > mlx5 did not due this for backwards compat reasons, but this is a
> > > new driver so it could do it properly.
> > >

Hi Jason - This also impacts us in terms of backwards compatibility.

There are current applications/customers who are looking at "'/sys/class/in=
finiband/<ib_device>/device/"
for sysfs attributes like numa_node,  local_cpus etc. under the PCI device.

i.e. assuming the PCI device is ib device parent.

With parent change to auxiliary device, they won't be able find these attri=
butes and potentially resort to default
configurations that are sub-optimal.

Shiraz
