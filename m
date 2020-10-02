Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DF728112D
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 13:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgJBL1u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Oct 2020 07:27:50 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3773 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgJBL1u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Oct 2020 07:27:50 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f770e810000>; Fri, 02 Oct 2020 04:26:57 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 2 Oct
 2020 11:27:44 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 2 Oct 2020 11:27:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHuf7v+0e9oUyXnIUirpafv/OfNJZnpCRAqGqajBoFusyBsnnCp/j7TwcTDAxIwUnzlV5cIaB2Chp7HJSI7BJtbCuZzASscsi3KqCoYhqa5xeN/z3qHN63+fK3iwnFqlN5wV66GP12LfDLtwcVnZKX3gJnAQz48j+m+jBYIgMiFrzdjjEC5j5rrqV60G7UQ7uK4urORDDEMYbzrI0E7J4W/ZWGZOBCYLBFDiaF41/DKn2fha9ufwzYpFFL2VjcYsG7J5GgRudggg6PLqVSz5hDf8kaVcQulw+vUKw4rnn2QgWaMip+p0t3KUx9nW4PhP0rA2aZaJaPrXT2CVx37G6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeHKqvhMrgxcudMxqVp72h/ULp8lHCFmJQECKPwPZS0=;
 b=T1lmJYQ9Q3GhxcwP0wPoiZwY9JfvFAMQ3iAPayI4D7VIVECQ8BUNsqu0Wne4779kLiVrguCoJcV+3a95+i4jftBTwJdwOaFAh9OSFnProcvhrjlcVbOy/xac5TKs+vhWNdgPlwhiAubWXMzKKbEndWB8d+aiRXWFUXz3YFTSM8y1GbP0QBw+Ble8iissnTTvaOi1qORQ6rvlvBUHv2yCAhOtHuWgRImbpsN3wp8Sx5Y6EWetTwlBeBFhdD49PM/jTK6s8XtPB9ht+bnWSYlI9nHqsA0PjJiHWYkVIm7Vw1Zw4HDMHxrdV6CNdwkA4chvYyTOQpV28i7XnDfydBGW4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BY5PR12MB3843.namprd12.prod.outlook.com (2603:10b6:a03:1a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Fri, 2 Oct
 2020 11:27:43 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::3c25:6e4c:d506:6105]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::3c25:6e4c:d506:6105%6]) with mapi id 15.20.3433.038; Fri, 2 Oct 2020
 11:27:43 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "Ertman, David M" <david.m.ertman@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 1/6] Add ancillary bus support
Thread-Topic: [PATCH 1/6] Add ancillary bus support
Thread-Index: AQHWl7C1MSqUSmitS0u6NuJRdy7sUamCa2qAgACTjYCAAAWKgIAABlCQgAAY64CAAKN2UIAAEZaAgAAjU/CAAC69AIAAAg4Q
Date:   Fri, 2 Oct 2020 11:27:43 +0000
Message-ID: <BY5PR12MB432201FCEA970DA28AB06166DC310@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20201001050534.890666-1-david.m.ertman@intel.com>
 <20201001050534.890666-2-david.m.ertman@intel.com>
 <20201001083229.GV3094@unreal>
 <DM6PR11MB2841DEF5C090BC8D830DEC52DD300@DM6PR11MB2841.namprd11.prod.outlook.com>
 <20201001174025.GW3094@unreal>
 <BY5PR12MB4322C7955974B4DCFC8078EFDC300@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20201001193211.GX3094@unreal>
 <BY5PR12MB4322EDDDF036BB58DE3A1F7BDC310@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20201002062011.GY3094@unreal>
 <BY5PR12MB4322C2E2E726DCF700802104DC310@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20201002111354.GZ3094@unreal>
In-Reply-To: <20201002111354.GZ3094@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [122.172.151.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb72545d-54ba-46a5-1f88-08d866c62de5
x-ms-traffictypediagnostic: BY5PR12MB3843:
x-microsoft-antispam-prvs: <BY5PR12MB384335C6BF6773C0482ED2B9DC310@BY5PR12MB3843.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R+qm9Wdkm4gUpQ7j/ICWWxoA7VwndOwXcs3vvl5PrayUefjYcUA1nUKJmZ48F4ceXjpUTGnQ47CrGs7r7nOcSVAVnT8Hz3aR7cF8x+u5FEM8PQyvFUQ+FLa6pIyLIDO6Sw5SZ0Wys3NHGxx3IDBgTHuqRsNY77Z0UbdefhzMSMr2d4oK1V641kHrqKYR2bLr9wP+61im/G3W8NwbOyBit1AK53Zf9jIun4XO11j6DZjp6/F/5DFB3edLuqTG39VpQ7L5Ofx6yNe+q/8CHHhyc1mbKBULN/S6HOSitIw0XdN+gzcAqgPhIkJJKLaXPdKdZAZZhT+YzvPoADQ7Bfoplg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4322.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(5660300002)(6916009)(478600001)(4326008)(8936002)(26005)(7696005)(316002)(54906003)(55236004)(6506007)(186003)(2906002)(76116006)(66446008)(64756008)(66556008)(66476007)(52536014)(55016002)(86362001)(71200400001)(9686003)(33656002)(8676002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: TO7Qc5ReVIwsQjDlj+I+qzflORRPPBp4aO4I6Ziy3AV3qCjDU0v8PP8LEZ0/FRAE5C89HnqaNtLjiANPVVF5AO8/GBmKJ5MqbaKXcUHBIijPhtarwMUTgp85BsrJiQpQQsP+vXD7KVvzdj9x9j1f/KFAf2omEUEMxooXnZvhsYiL7GkPuqE/8Eb/LZVInECZvij+JApgm/7WIclgo3NLHiPWGXA5mkOt2CFCovoOg73lSooDG1Jm8ikBm0CBZt4O0Dt2oWaZ6KcNc6RZGCc3uB2fR5dWyWdMK2ztKF3XyStQe51lRrz7+DXdEcAgSDMEWiQ4MFysGVAtD9Pwvs8CK7zWL8bnCyO6DGPimjf0Od+nSs/GKw+gCNyMjZCZFTJPNL9YjphH8oiAXMhS62TlomwIfU/1EqZNYTTBrj+SPjU5I04AD/jaj1RS+AQmHOtENsojh5+j+XbsXN8N9cXv3eXPZngZtNzL7ciPKPnXbyvt8MaDQMtxmvchmToLYACYMP89TUs1on60puor4KJTuybJ9q7K0t2qznNyLFyUxLUYUyN+YH9jQO7kOH5v+QK6sH7P3Q3ZTXjXbXt8zk1/NChBCDlIUkiTav3DvSz9tH+vxRME6GgXG4nR4u6Qkj98ztd0mRZKLTmWyypZuXJJRw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb72545d-54ba-46a5-1f88-08d866c62de5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2020 11:27:43.1368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KOuhUIqzhDN1XQqHFSrnT0AClXManjnjUXOr7atI2RPraQU4eBD7JfHIoBopsb9DwrAwQ7PmvxcREvvKr0Djyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3843
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601638017; bh=EeHKqvhMrgxcudMxqVp72h/ULp8lHCFmJQECKPwPZS0=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
         In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-ms-oob-tlc-oobclassifiers:x-ms-exchange-senderadcheck:
         x-microsoft-antispam:x-microsoft-antispam-message-info:
         x-forefront-antispam-report:x-ms-exchange-antispam-messagedata:
         x-ms-exchange-transport-forked:Content-Type:
         Content-Transfer-Encoding:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=EaCELtJGrxRfEIBdP02BRdcZI2U4xw2VDdl4Y01svQqT9Y9SbtRW2AkLsBJKKnx+U
         jGqyRrD1mjczWm/1IEhnTkoir+8sBDtQZ08Y2q9P7cKg+OJOQSRwwdeVlMmHcHT0+Q
         u4Mh6R5yiYs3BYNJixZVsxzBeRQzW1tjCT7btZvxNCsHtCkrDSKsnuZpFuVav/KRFv
         O7Q2TEWPNKgsCs8gHJhk4EL3IFXDgEHSxZbDwXwubtqgSABrkVvlBikQ971hfN4NNn
         fSXBcKtIkE44Mbrib6VyqjglzNpcnRoFNHil+eE8QRtf/I7Rw3cdMl8gd4q19ZOaih
         +BRlp2VW2qJEg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> From: Leon Romanovsky <leon@kernel.org>
> Sent: Friday, October 2, 2020 4:44 PM

[..]
> > > ../../../devices/pci0000:00/0000:00:0b.0/mlx5_core.eth.2
> > This gives you the ability to not load the netdevice and rdma device of=
 a VF
> and only load the vdpa device.
> > These are real use case that users have asked for.
> > In use case one, they are only interested in rdma device.
> > In second use case only vdpa device.
> > How shall one achieve that without spinning of the device for each clas=
s?
>=20
> Why will it be different if ancillary device is small PCI core?
> If you want RDMA, you will use specific ancillary driver that connects to=
 that
> small PCI logic.

I didn't follow, wwhat is PCI core and PCI logic in this context?

Not sure if you understood the use case.
Let me try again.
Let say there are 4 VFs enabled.
User would not like to create netdev for 3 VFs (0 to 2) ; user only wants r=
dma device for these VFs 0 to 2.
User wants only vdpa device for 4th VF.
User doesn't want to create rdma device and netdevice for the 4th VF.
How one shall achieve this?
It is easily achievable with current ancillary device instantiation per cla=
ss proposal.

> Being nice to the users and provide clean abstraction are important goals=
 too.
Which part of this makes not_nice_to_users and what is not abstracted.
I lost you.
