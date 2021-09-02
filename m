Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EC03FF039
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Sep 2021 17:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345689AbhIBPap (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 11:30:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:53517 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhIBPao (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Sep 2021 11:30:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="216014641"
X-IronPort-AV: E=Sophos;i="5.85,262,1624345200"; 
   d="scan'208";a="216014641"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 08:29:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,262,1624345200"; 
   d="scan'208";a="646396154"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 02 Sep 2021 08:29:45 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 2 Sep 2021 08:29:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 2 Sep 2021 08:29:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 2 Sep 2021 08:29:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knRndeAxxUtCtPvbFLck+2a7/6Y7gypu0dzMA1IFkuY2H6yCm5c/lMEyDG96BCzd2ci2CCF7QBuDEN+Lb8qLVfjSiSyYQPScdgRUGhC4KI4IDyrJrqArG4rtlo+NYyvQEO4vdS/BuiF4CvQ0+xnO9SHgfbdzuvlj2CN3MHx7k8W3uxd2e52SCQXIEYyiY3frz6HqTfK7IF86/uS6VO28uvdZhJ3Z5ABDQROsZW9wCP0JtOgF9xbAAN9Ps/pH1Wy2kY6S9VUXv6zHCbWMK+REove2akEKRQ2rCqoDqMIfQhT+kR8SJRW0tEiwwLOtuCW4tR6S6sPukBwS4ct2TCGPdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fpHZXMvUh2eZAi/An3mhcCvg7XDGvZ8rG8dPFg4HqjY=;
 b=d1m2oqdaVsnVxn7M7lpQmWS/3y5O+yPRdH95VTOSjdPFjw+gGkf9DIelYLfq6KeCEs/9bjp4VdVPQMA3Dl59LtNlHyNuizTKgNrOFArs+Bpaw5d+YcQ1kP7vkHfGCoxYx0WAj+QL7XB+AvqHEura43VlulsgI7Mn6Za7cj0B0yZ3sbHxTvrprKU1s+Ou2H1XkW5o7BfeLGhEPXNiq34Y9rWj9YUs5ERvLh8tf5ZmMOqdnSSKLGo7sfXa9mSBTADrg/038pdMKz6cec4ueHmqD88W8v/P1K5eJM2X8Au8/XR1HKyeL1X+50FHF5hxU9/hXyLOo2eV8s9aS5TKVV+5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpHZXMvUh2eZAi/An3mhcCvg7XDGvZ8rG8dPFg4HqjY=;
 b=cyoVuWkwM5ESFQmjNCkeOp8/oRReUwZ6IFIHwm5/0cCiPy4Hzyw1LEeCfKs3uvx3qaahHksZNhTABKyu2W0BCHcQUeGIAIBlWCJvJkACLQ7+3mlTXB846a4UUbthW7enaZkQ6QLK1vd07o0olmlKI4cG2HSmICn33ez4Zc+UK6Q=
Received: from DM6PR11MB4692.namprd11.prod.outlook.com (2603:10b6:5:2aa::11)
 by DM6PR11MB3867.namprd11.prod.outlook.com (2603:10b6:5:4::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.19; Thu, 2 Sep 2021 15:29:43 +0000
Received: from DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::31db:f34d:bdc9:8f32]) by DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::31db:f34d:bdc9:8f32%7]) with mapi id 15.20.4478.022; Thu, 2 Sep 2021
 15:29:43 +0000
From:   "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
 rules
Thread-Topic: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
 rules
Thread-Index: AQHXmDZjOykQbRhbB0OylwgVwYR9l6uBQpMAgA+prJA=
Date:   Thu, 2 Sep 2021 15:29:43 +0000
Message-ID: <DM6PR11MB46922D3AE92E34B4E1D3AC9FCBCE9@DM6PR11MB4692.namprd11.prod.outlook.com>
References: <20210823154816.2027-1-tatyana.e.nikolova@intel.com>
 <20210823161116.GO1721383@nvidia.com>
In-Reply-To: <20210823161116.GO1721383@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8f638b0-9875-434b-e895-08d96e267ce0
x-ms-traffictypediagnostic: DM6PR11MB3867:
x-microsoft-antispam-prvs: <DM6PR11MB3867910F730715634B2451EFCBCE9@DM6PR11MB3867.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +O1jFyNquS0Ipz2DIvjPS3d44/yuVpEGtDUQWgiRxsZ6gom+XWIUeuQJS1MlVyAj2MDmc8KJjeGy7KdgzQpd/iiMiu1HumxAYYWz8eYkyKqy2jn0VrtwwCL800XHZykOGOlpQn41ndvlTkYFvM2anLa/NbAaJo4DPhIWn7hRtB4WMOKdXhiMqgRfR4Nma3naKltFwinMjNb6TEldQsz7K6XV+swD9VnlCZofabdxTFXWbJWQdBqM79qrVX5qmWVMKunjnvw3JBXRavnAqHHYHiozr4Sj43BQVULoGo0zbskf4sBbqXqN/9U/y0kXOp2GwVyj447mYLZ2TAtqluecOZCuFoH69fkEiUru/GZ/ErBQyusSEbzcF/JG51vyW3NurT9ZO6iVn2riJztnTVAF/zfFwVejl+i6mVsgOxExvTi64QhoriBMfNjst/FmN2MS44I9PacwdnB74qsVTIFFm/2PiwVsNQA4AN3Yhj1ypdMlMg6EbGhdtt/RKyvx+eFhL4Nqd3hkDjEUwiPJJXDPPe3XeOJzL1pCIHYtnvcg3ahvWmVcJIbu4xnlkpnWSL4djs/7ArXtHYPYmxieQ7fD/NNwqurAezVge1J0byNxton4a6Pe8QXPMO6egHLcxQx7DqmwnTLflIDU+VfA6SxBQLT672yzTzGg78oyOpy4sECn6reg3biwEkJOTMIESicpyiZotJXwWEHh4+yq/RjWew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4692.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(83380400001)(33656002)(316002)(53546011)(6506007)(38070700005)(186003)(52536014)(122000001)(6916009)(38100700002)(478600001)(8676002)(5660300002)(71200400001)(8936002)(4326008)(2906002)(55016002)(54906003)(9686003)(7696005)(66446008)(64756008)(66946007)(66476007)(86362001)(66556008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wh6HjCmbwsRVvd/MQAvm/WTwytbhO8/zB/IHF/kd8E3pS0H4NfAxst6jTG/d?=
 =?us-ascii?Q?ZEMb7CFKSNYaZ3T93XNVUS6QPf+3FX8lILZ+cBduLZuoZYzJX3sb1tboNypL?=
 =?us-ascii?Q?L0rcRJfnihKGL86Cutkfq/UFbKpwnwpBh7BuW8gH1+MyT5pZH8WNPbpPv8xh?=
 =?us-ascii?Q?poasyYWmQc70UEMJjjJA3dL9YWm+aR53hFUbNCJsnubEB/1VMUK/zaUFZ7do?=
 =?us-ascii?Q?B4nMk9BpsjaMViaNku8HmFtCmjIvUT65RiqBk9juVlIgJvlD4petPFvISCMa?=
 =?us-ascii?Q?9DYu+9bFO06Tzp7uOdg6ltKOVd/KB35I3t9Z746UN2B7Y+6/+7ae0rCFDDKz?=
 =?us-ascii?Q?KMaE5mbrG64/pcLa0OP59JbCNIHOCZ8J8RNhTSkzuXv4SrMuPGwowPsVdWCW?=
 =?us-ascii?Q?jmn4V1RlchhbaqG9gp3O+IvuufLOeIV8kw2xtKaOjF+VhCdJBUkRrwodT1RP?=
 =?us-ascii?Q?LDYSLKWwZI03HuQOA9dd1CPOsGZfIIhKtopeYG7IwNqhY8ACUI15ilLMLPrL?=
 =?us-ascii?Q?uHrGV1xzSvcvROo4dJWdmdTpyGepJFS6vAhgO17go0r8ilT5VPol+1a/Y/uh?=
 =?us-ascii?Q?6A8i/StkxNxjyUo+ySweI6B4n7kxloDNYduYDr2lxKiUZXXPAHzHaCbJwBDx?=
 =?us-ascii?Q?olhBQKxgDln/sS7DWG29G366f5O4tfr8fNOalBWWEtVEtC3lF9GcTWxKgpI2?=
 =?us-ascii?Q?O3L2hHNzadppjqC25Jl21R2utkGEsL3nNCcm+aF6pQ9AWf8MqoYteQuDsVKo?=
 =?us-ascii?Q?8JsJ4ET/V6MpbWp8q7U6xo0WeFgK+ri2F7j15brBqJRu5ETE6jSoZrYOUD2t?=
 =?us-ascii?Q?69fAcioslgu+cw4CRfgmlKwjY51sFvthkVARY+JuBU1lpoByf6jV21vJG+To?=
 =?us-ascii?Q?n1psISmUPQ5qwAZGL5ylZtFfHRLdsz2pLSZvZaojiUWoggm91zYGwe4e/k5D?=
 =?us-ascii?Q?uZjXMuzOigWU3H4uNY1zuCbUHX1EuyFXW0qCE5qfRTCkuxDXec8g7EvKu7fk?=
 =?us-ascii?Q?O62Zj8qRtgNdNlix8irQlnAqp9ZfY6/7inwrkcQDkw/QvYk8qUx9IY2tBjHY?=
 =?us-ascii?Q?0QMd9PTSj+GIaqtaOq6xxmxyvriW3ABwaNYUZKVIg5HwPt7H7Fu/eb3x+uvF?=
 =?us-ascii?Q?5zcrQ0QPSGv9J2xf9VvdTyLFnxdhfmaRMJzBL1t2pFPTGnhjPRXDgUGzppyf?=
 =?us-ascii?Q?6lKvrE2Lmb3RfQWBzvZ5jARdHMSNrPvMOVA1xGp/MnIzIw6zziht2BO9vkS5?=
 =?us-ascii?Q?GVsKFJmw1h9vLjIwSCw4ZAWfdDBdpgV1hcVjP3jsi4Q6dHl9LOEFxyB3aXlT?=
 =?us-ascii?Q?4RjnPLtU0QMfzJAvQSkJjstH9Cj4ziADUBjd8OCH3PQ/cup+1JNZ8tmkJAKe?=
 =?us-ascii?Q?bH3KiIVbJAzFQ22I8LKAcNUDN0GS?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4692.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f638b0-9875-434b-e895-08d96e267ce0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2021 15:29:43.2224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nYWfgclt6HLBetGUwMgrykWVOQCihQxJPMDvlYhOa1CkgqzssLA0+rsH9in/Uwq0kFM7gBpmtqMCrEl+yVOcB92GB5pkMGuhmhm69+opQec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3867
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, August 23, 2021 11:11 AM
> To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> Cc: dledford@redhat.com; leon@kernel.org; linux-rdma@vger.kernel.org
> Subject: Re: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
> rules
>=20
> On Mon, Aug 23, 2021 at 10:48:16AM -0500, Tatyana Nikolova wrote:
> > Add ice and irdma to kernel-boot rules so that these devices are
> > recognized as iWARP and RoCE capable.
> >
> > Otherwise the port mapper service which is only relevant for iWARP
> > devices may not start automatically after boot.
> >
> > Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> > kernel-boot/rdma-description.rules | 2 ++
> >  1 file changed, 2 insertions(+)
>=20
> Given that ice is both iwarp and roce, is there some better way to detect
> this? Doesn't the aux device encode it?

Hi Jason,

We tried a few experiments without success. The auxiliary devices alias wit=
h our driver and not ice, so maybe this is the reason?

Here is an example of what we tried.=20

udevadm info /sys/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
E: DEVPATH=3D/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
E: DRIVER=3Dirdma
E: MODALIAS=3Dauxiliary:ice.roce
E: SUBSYSTEM=3Dauxiliary

udevadm info /sys/bus/auxiliary/devices/ice.roce.0
P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
E: DEVPATH=3D/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
E: DRIVER=3Dirdma
E: MODALIAS=3Dauxiliary:ice.roce
E: SUBSYSTEM=3Dauxiliary

Given the udevadm output, we put the following line in the udev rdma-descri=
ption.rules:

SUBSYSTEMS=3D=3D"auxiliary", DEVPATH=3D=3D"*/devices/pci0000:2e/0000:2e:00.=
0/0000:2f:00.0/ice.roce.0/*", ENV{ID_RDMA_ROCE}=3D"1"

Thank you,
Tatyana

udevadm info
> > /sys/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > E: DEVPATH=3D/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > E: DRIVER=3Dirdma
> > E: MODALIAS=3Dauxiliary:ice.roce
> > E: SUBSYSTEM=3Dauxiliary
> >
> > udevadm info /sys/bus/auxiliary/devices/ice.roce.0
> > P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > E: DEVPATH=3D/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > E: DRIVER=3Dirdma
> > E: MODALIAS=3Dauxiliary:ice.roce
> > E: SUBSYSTEM=3Dauxiliary
> >
> > We put the following line in the udev rdma-description.rules:
> >
> > SUBSYSTEMS=3D=3D"auxiliary",
> > DEVPATH=3D=3D"*/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0=
/*"
> > ,
> > ENV{ID_RDMA_ROCE}=3D"1"
