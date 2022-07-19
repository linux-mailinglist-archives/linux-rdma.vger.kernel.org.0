Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10F157924A
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jul 2022 07:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbiGSFF6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jul 2022 01:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiGSFF5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jul 2022 01:05:57 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84B065C2;
        Mon, 18 Jul 2022 22:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658207155; x=1689743155;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lG/xmNWSAvUhEHwCl4IFQqzqfLg7IXVbwE1iZXoXZM4=;
  b=CKrJ5R6qIBMYVNgHfs6Zzp00XPZTz9ydzY6m8ga4jgIOB8djTqY4sFY/
   H5/SiXMUJAVmw49q4IHQL/NfcpyofYvvLTTHK4ey4XEvC+L3P0Llr2fts
   TatWtM0ndhA0OnjyxCnOlzgJvzFNG9AJmddHSUnrC3+jn1/60L06IYLw8
   qvKoWt+Oq42l+S51A1jmz1dLdhMGnC/tbvYds+H2HIwpsX/lEGP4ZNcQ9
   ZN7cZnD2ByCVWNubyv0itI8CvSznjJHVMN65d012jjL+kJRyoQRPDllK2
   MOhLvXmuq97JqJCoi8gY+XDnqgMb9PPfSnhOp3jv0H3hmjqnSgpsGUG6A
   A==;
X-IronPort-AV: E=Sophos;i="5.92,283,1650902400"; 
   d="scan'208";a="211241557"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2022 12:42:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQ+TbiguZLvUWQ6uwiJChH1PR4DNpWJpr8YSiuaLQotoGiCcBhfPKAUBy86E6iK2bHY75EFwLv6RQISW7lHxMOZjj5/GpDXcxl8rsbTGeEM5NgOZhUucCzo0hSk38h502CSZwvjyMcOcILpXFSGI0WHV0pM7p+2zCA8qNA/gEQVoii/dwWLs9/5Ub6RCRUNr1jcglaVPg2ZaivPx+rSyc5Jf6BIItR2BFiH9vb4EAzDsfgp0jevjTyodw1jBOwmEVXogm/PaCGFk6XapLl7xaktAVJ+HLZHg0+vY4M0S0PtekdbIuVVmkISPt3D3P+QL7JWnXT3uFrcqaIvzak/HPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjG3LH5BCWh/sfjUAVBkPEMOjz0uUY1wPALaw/86vrI=;
 b=OQCi7mmCfJ6IPpmli6GIHTJYtXa180ub94K+gU8znCY6fHJK/G8bC1CtktGrizSgZA35oKyt0mITiMlWOdoVwI6flAe2mu3pp98M8wFhcJufZLKZr0xdvp1T4Cr5+Wjm+vypTA7Pyewt4ACfwqq1PMaN6i34W4LdM9YmO2ExbTnwxJ0WWwrVlqL9S9e3eFTfcnnZyGN3EoRDe7Ak7LvugnzGJHBYKNNtlcUyunCPG1DiXNSEZZLq/+d8Kpmn/r2S+yCXpxY2Bugoj0RTWoQHCP7eSO3CHcXeh3225hRdSJvx1U8ajDWNcVnQDXH6O1U1BELe18/oOS+dHQNrwAcELQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjG3LH5BCWh/sfjUAVBkPEMOjz0uUY1wPALaw/86vrI=;
 b=k9JT/7oCfcfetvScohK2ECKKFwzHAMENuvEEZOQz+/JCu8eMqL8NIWSyU8w+UNshUc5l3Mvx+ldaK93NTNc0YtQgUOcdJAUziUY0VTh936nuPZNmFKI406FVndhtAdUvXDZwfDAtXGgU0/1+lerwHnkSKLa/cD4X2bbemUC9exo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB6768.namprd04.prod.outlook.com (2603:10b6:208:1ea::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 04:42:17 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%9]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 04:42:17 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
CC:     "hch@infradead.org" <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [bug report from blktests nvme/032] WARNING: possible circular
 locking dependency detected
Thread-Topic: [bug report from blktests nvme/032] WARNING: possible circular
 locking dependency detected
Thread-Index: AQHYkAjmw6XcqQ1UdE+2h2wJPET+mK2FB/kAgAArzAA=
Date:   Tue, 19 Jul 2022 04:42:17 +0000
Message-ID: <20220719044216.p55474yfbwra2p5v@shindev>
References: <4ed3028b-2d2f-8755-fec2-0b9cb5ad42d2@fujitsu.com>
 <YrqauCHdcieF5+C7@kroah.com> <YrqbNfF9uYMSwZ4V@infradead.org>
 <Yrqb47ozk5IWTnWp@kroah.com> <YrqdUpLVbLF7WNGs@infradead.org>
 <20220705004809.6guf43xwjpq33smo@shindev>
 <33e90f37-c201-9ac6-f65e-3646341dcc2c@fujitsu.com>
In-Reply-To: <33e90f37-c201-9ac6-f65e-3646341dcc2c@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60f677b4-4dc7-4f2b-c1ab-08da69410f04
x-ms-traffictypediagnostic: MN2PR04MB6768:EE_
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GHG5+nIcctD9A28bloOO7Ixb+D+ysrI5TmAKtEs17p7tN/5O0ZXAKcgwsTU50PYQDiPHGepuRrcvgiDQqvribfhGzkFo5v9KhSWl6CQbNwdA5BXjauEWi+m0VxwFaxvAamevffzrRWqvNI5/DiV5gnBxFL2jjUfCznD9JbE+t0GZHIll7h3w3pd/ZN+n9Jyk++fgkbcVa1tdBzO/BAddJO1bYNEzvihQl1jLt71Hx78xQxuMKnHwA3ZR2osbCFqad3xD5fxuXQdN3SBSx26VOr5fNRE/6tqWrdeiOb2WZw3qaLlVDZyFVGpeZcI+uZ+d972f3UmqHI0nxtEHoL+AKrFrjLdqcRexAm/m1i2dP2VmZq6kYKytFMc7K+HT83beydXsXOKmWRbmIHD/AtKDQ49D1V31ppQM6gDLIpEpcMrnqykPKOI3Gm0mgzJ+mvBfEBxMc1SKAosr/iw8oY4qLirZpI+KXxPivJsGJHuU9b/JS0HzIV/1kRsfKVdWDZT/OaVH7FjIEd6rGPuTbYUNOy3096vtVJPW/WN5Z4vtW2Q9LyQTXoPQqz3uDxVM/2fg7vpte/uQWdQyjiOjsLDsVjZcHaR/cX1AvAI33eEAiyC0L/OeD1+JJMxiC6J91iDM+lNnv4Oik2XjMyoGpGPnvATLM4PCTPfu4A97xnj+HFQNMnrG/UzRWDcdY+PVvE22baH77oZS1b9KMfBqjEB1H+eAod8hYAhhQE+j8vDrBCI4eITQZlibpCZ28RjagZT7UypQQ905NQdKhgKQWNq1De0GSdca6UWLEDMoUuemcEh1KutdNZ/VPYmqUXYrzi9HdXOgVw/Qugzbky6K692+sA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(41300700001)(6486002)(966005)(9686003)(71200400001)(478600001)(1076003)(186003)(53546011)(6512007)(6506007)(26005)(82960400001)(122000001)(83380400001)(66946007)(38100700002)(66476007)(66556008)(4744005)(7416002)(38070700005)(76116006)(2906002)(44832011)(8936002)(5660300002)(64756008)(33716001)(316002)(8676002)(4326008)(66446008)(91956017)(86362001)(54906003)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kiGCvpogE9t5gzis08hwnjltViM4o7amDGZgb9dZaIF6qur4FhFlQeGBxogI?=
 =?us-ascii?Q?oY67LFpzoLtqNcNPX0ynNlVRL5pa16kfs22EtjVdXexY/dJr6MBSznU0SM/h?=
 =?us-ascii?Q?IlHILjVEcxO02x0noL7PLKU0wLILzqmyvLGfjW8zuAcKZzRz/2P1xYxc+ORK?=
 =?us-ascii?Q?TzrMWSLmNk5/qlHbTOa3u71CNZarnesWrigtBZW8g1ZLfCl/xlLiiNMiczlW?=
 =?us-ascii?Q?lvpev6FJcrqbb7uBe6RA0N67v4YXI8N+2rmFs3OHN3oYwg97HRUaRb6Flw/f?=
 =?us-ascii?Q?aRje74CadIM/+wiwL5xiCeYE4PAV8BVESFuqtee1zGDOryRGqlmR/ro//umM?=
 =?us-ascii?Q?6iCn4qGylU8362NZ6AgvDOyifPc7RWW0lnqGs44anvydukbkD8WmSf/tgEK0?=
 =?us-ascii?Q?VG4zZVI4f+eVl4KPhHOZu7sdUaJapf737rMXVGC5BSbOJ8N5tmq6MvXMYlZ0?=
 =?us-ascii?Q?WjFhtkc9oA/pyphyfci4RFhXJzjQA4Jioq+hnffaIxznZdJm0NN6w/Y2A3kI?=
 =?us-ascii?Q?7n+0VNPiKlHyHVWKpmFqyztJaAABZ2PanraDMCMYOp0h5LRpgyu/CIWrb/No?=
 =?us-ascii?Q?bD7Uss6vXHHiEYGIlpSzWMqn6Z2m0yGyYtN7vDFHrXFusgjUavmvFawqjU3e?=
 =?us-ascii?Q?Z+PsSEppMfkqtZ0gaa+cqICHYVCFqvIOT1TfIjGRASI7dJjZiUSniMLNEZBo?=
 =?us-ascii?Q?7PUwcd1aUxwR1zTzX5+jAArsXIGRRa1qq9rkwxbXax0P6EaAmaqR8v9y8LY2?=
 =?us-ascii?Q?xAnl21K0PHLYGIwyAc2h6mQefkMSt4yc59NRShLq0DCJB1DQf9ynHWdofsOd?=
 =?us-ascii?Q?liNsbpOXRtJHKlF93vFtmjbJO0topzxef2MyGI4hozIjbEKBtbCAmJaGaDSH?=
 =?us-ascii?Q?uHg8SwoWZdmqYPeBpNKmvrfTdypcEL7GFS1NALCCfzYpupNB7HjuIplqQAqh?=
 =?us-ascii?Q?mpQVVpfBYnWjd524ALv9+FWgBMhMQvLycSyRqp6JGJJ5qJVDkjOcgBBrjFIB?=
 =?us-ascii?Q?9NQn5nA6D8Ke5+erFWJrjE0IsTwTu6U4JNExm2nyaMP8co9Zo1zd4WnagtpD?=
 =?us-ascii?Q?lYcdpP/MKrb0L9aHwjBB8aOaQVCeN2WmJOZ9xnvLul+Ez9oi+T/NQfIrXA+k?=
 =?us-ascii?Q?JZ5rhuJAt+dyxGt0Hrh54rQf3VsnPbAfWK1LRbUMQ64d0G8AA7Yhl5jOnTCk?=
 =?us-ascii?Q?+9rZkM5629gkDedLOKa7Ya9ldntPW4c3VmjUxgInApFi+btVC+amQfTrIa4q?=
 =?us-ascii?Q?nfPe8L7b03wsEfJPxNZP921IlYpVTTQfQWfWWgMICFK/5t4jdVm2f4XsLwXV?=
 =?us-ascii?Q?XJJgZ2IkAN/wEcD+osrhIhV+AXMAcRAJuEBlR+nqiB7Kkj8ez7HMzBIcMqMc?=
 =?us-ascii?Q?tPoQQsI/FdtBtfChPImmLFJpYq/w4Y4rIYMjZkcZkjKJSXIbde7sd/7c2JCU?=
 =?us-ascii?Q?L6YdA+B5MhNhO+2lnn9pIT34HXXjXPlwi/OfdgTUn1As92ezgTztNQTlwb4S?=
 =?us-ascii?Q?/JH97mkmoP4gt9NO/nM1yj/g3Gm8s46ifxTnCr8dkk8wlVzPlunv3CIrillk?=
 =?us-ascii?Q?mlcd2BIBFASAJ1XXyJsAoBdKKkMc0g6ahIPRDUw4Cf2swOebej6bydFeHu+Y?=
 =?us-ascii?Q?QtEIu9H+UmH92b/ngDU08VY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0FE87EF953BC514DB3B465F524C8B49F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f677b4-4dc7-4f2b-c1ab-08da69410f04
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 04:42:17.1638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VNd81DEVZo2+td+zCixSpzTpuLLKeK2XDGxYBHEj6Xuf3lTmZTcD74Yno2okWnOJdre2fgpleNND5L9gx0hBuKt/k9hLMY8FMVeRQsiCr+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6768
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Jul 19, 2022 / 02:05, yangx.jy@fujitsu.com wrote:
> On 2022/7/5 8:48, Shinichiro Kawasaki wrote:
> > On Jun 27, 2022 / 23:18, Christoph Hellwig wrote:
> >> On Tue, Jun 28, 2022 at 08:12:51AM +0200, Greg Kroah-Hartman wrote:
> >>> Ah, so it's a fake PCI device, or is it a real one?
> >>
> >> Whatever the blktests configuration points to.  But even if it is
> >> "fake" that fake would come from the hypervisor.
> >=20
> > FYI, the WARN was observed with real PCI NVMe device also. I observed t=
he WARN
> > with v5.19-rc1 and still observe with v5.19-rc5. I'm not sure which ver=
sion
> > introduced the WARN.
> >=20
> > I once reported this failure, and shared with linux-pci list.
> >=20
> > https://lore.kernel.org/linux-block/20220614010907.bvbrgbz7nnvpnw5w@shi=
ndev/
> >=20
>=20
> Hi Shinichiro,
>=20
> I wonder if the failure has been fixed? If so, could you tell me the fix=
=20
> patch?

No, I'm not aware of fix for the failure yet. At v5.19-rc6, I still observe=
 the
failure.

--=20
Shin'ichiro Kawasaki=
