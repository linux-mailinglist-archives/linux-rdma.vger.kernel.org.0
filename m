Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E05172F711
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jun 2023 09:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243564AbjFNHzR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Jun 2023 03:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243571AbjFNHy2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Jun 2023 03:54:28 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22BA1FC3
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jun 2023 00:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686729233; x=1718265233;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Jzizzb/qzy1VPy9F2JlTojxoEKNRGHlncfJYrJ+zic8=;
  b=q+5feCOEsX/FMXvIjypcbicLUZBWQaTRtqnRbnXXbPnTIb5uFzRAY4RJ
   8aOziwnD76NAvhjZW+PD+Ck0o7sqDqEs3fz7iq6DAeYuGzWwro77WjVAt
   wJDTXsTM+s5GEIcpW3m/VOCtkE1rsY+8aEGoekYkG/0Jac0iYoOaGiijx
   aQiQutpRsuPoCZUH14a1rigVr00MGGLWW1rCqPbJkdNYgYRnA4I4nNIo+
   LUWXRXAU7+wFcQXnNexg3m+0sOvgT3cCbJBF6HBIdzhmoTFxsxOPtb45Z
   632IiQE2JEqccXHpGs9Mxq59BnvyIZHIfr5oODdjxM+IKcIy2bcda/RA4
   g==;
X-IronPort-AV: E=Sophos;i="6.00,242,1681142400"; 
   d="scan'208";a="233757839"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2023 15:53:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVeKAGr+7IwzPZu1Cv4K4KL7FW2yeM1jyVlmNyJ049i6cec3FTVcObCvqHxSxKsLUGW6FX5gR3xBZ8Xe286VtR7QskPa8rEv7v9BO+lzcD38vGlqnw55TQwIvDZ0+ThrZECfw5yBq6lO1GG5kUO2OY1cQKClCCQbV225fbkqzlBixJDhA++2E+4l/V3HnEoqcAacxByLqsbiqrUG9pLctwfArM+pvPxM0oiuJUedR1JjCIjTZAA4iDrcrYPad/c4hnmIUmfNq+YIRgXogATcSHiCWQXYd/V1+VCVkStzcMKKvnmhVDOPeXwq7BSWNyCS517+VgRGy6LKqJbUt/uUJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFx8IXQslnj/mO2sCPj+R0YSC170hiphR+gakFH54YQ=;
 b=flcrZLCTnybaI4ARHE35moOc9VP71jV3MyObt6caBkLcgmSeLhgUm7uDGIBlq6p8yyKypQlKOwHai+nMwuBeaQMYXRXkU8M5etZ9ma3d1CcI8EGKVGYDd5HT0xb0YzTFPLBEXSOwjJvWB+096+wKz9kA5QvLdXkc2Dg2UzFjvAcVMFrdh8oqPzVAyVVm7VfXnMOMEqAnVYRYQDPcbAShlMKotCSs5VQF+m0sqeOBqtePaZ8qKqXwdyY7DwpZgdAX48ExUWDgkDyYo2zzLMhm53L5nUyan7nWrEmz9pTRo9MMJt5u9eWxsErgF1gQERyHf229vBmbmyM/RwaDZyO02w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFx8IXQslnj/mO2sCPj+R0YSC170hiphR+gakFH54YQ=;
 b=ZTcURhu6uQJt7sIex9u68DCq9lW9nYA46briou84EnflJbOA3zcNCmgQ1U8pwuglBmasWNbLKltzF5CkaQrhkHUKMsb22urz4iT3Htyk8tTKJcaxrUKr8EdoFXLyr2cc17MzKhBZiCVlu8HdaeBoWm0r8ss4bSqe8NI0dxmyiUY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB7123.namprd04.prod.outlook.com (2603:10b6:a03:227::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 07:53:50 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%6]) with mapi id 15.20.6477.028; Wed, 14 Jun 2023
 07:53:50 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2] RDMA/cma: prevent rdma id destroy during
 cma_iw_handler
Thread-Topic: [PATCH v2] RDMA/cma: prevent rdma id destroy during
 cma_iw_handler
Thread-Index: AQHZnPC2s/8x06ig6k2H99zVQRnT1a+HN4aAgAC/dQCAAMWdgIAATXGAgADmt4A=
Date:   Wed, 14 Jun 2023 07:53:49 +0000
Message-ID: <iclshorg6eyrorloix2bkfsezzbnkwdepschcn5vhk3m2ionxc@oti3l4kvv4ds>
References: <20230612054237.1855292-1-shinichiro.kawasaki@wdc.com>
 <ZIcpHbV3oqsjuwfz@ziepe.ca>
 <3x4kcccwy5s2yhni5t26brhgejj24kxyk7bnlabp5zw2js26eb@kjwyilm5d4wc>
 <ZIhvfdVOMsN2cXEX@ziepe.ca> <20230613180747.GB12152@unreal>
In-Reply-To: <20230613180747.GB12152@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB7123:EE_
x-ms-office365-filtering-correlation-id: 2631a0fe-ee62-4332-8fa6-08db6cac7d89
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: reYXuRN7+ZiNDli3Lzah2gmkd6JPPxbWQLRXA4oLjtfFOLYfZMWmsDqipXGaJDDLM7Ja4u8w0M34UUNwQInslt8OyxADKIa4n3LrDC+oGkE1aVCxRpdJCRfRu6Cif/UqvPlFim3G5uCdo2IGz5/kO6dPc//mR98iKXtxviGxeZaPPJWIIHr597+qxV5ZlZKGb63/HLkfbut7hDlfuqnv5CeZfoHPwnkulIbJUlxPqhelSwbMdxVns35pqUk79cqqkOHSNyf/5svI6Ms8RdjzufS//9Ktv0JY0Zs1QL3UyVb2/PPuGqlwEkyK/Z9Zd8Karhwzow7zSddj4Sweh8gF09OlR0JLHjWPxnRzMEYXVyfUkSZqIeV/vbZBPTVKTCiE2yuAvUvUVxzeq9zTKflJqmJ5YUIa/cGqFAMTXerWI1BfiImnRnFWqOEd/8NpOpJAThgvc2p+tq9jiy/Bl3/I7/T8smK5/apZqTkRXs7JQ8Kd/VmKqpnixc8NK+ZF4d/h71gWsBqkK9jLFrDYO726lmaEL4VXzt00OB5LCURarm0pECNoCMx5NvpTwZzLAM8/lGAl8ZwthtYC+XXS5rAeUOZ5cRNg115PxOm1Tc+dfzfjulGIe9plwBkNpOK+68iM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(8936002)(9686003)(6486002)(26005)(8676002)(6512007)(41300700001)(38100700002)(478600001)(82960400001)(86362001)(71200400001)(66946007)(6916009)(66476007)(4326008)(91956017)(76116006)(64756008)(66446008)(66556008)(316002)(122000001)(38070700005)(54906003)(6506007)(33716001)(44832011)(5660300002)(83380400001)(186003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uniLi3rV6sTQnH7A1WsHITPfRmGS9jys7MV+qqHqxCPH4CS7ptYP13YNRvIq?=
 =?us-ascii?Q?qVRs12BBoEkCVuUbsuWy9fEfMWN9o8KdkIajZrMjIstDockU1tkOU2C/v92T?=
 =?us-ascii?Q?C5sKCLscsK7TjckMDR9mvPDUQFsCWNiOo6oZN8lvFBUP6W0pwdmx/cCVg92T?=
 =?us-ascii?Q?yK2jmcIlIRpExm7oM2UpIAM4Gxni23CcFX+Y6s4U9tDMWi3bQ6+7QwRzAthO?=
 =?us-ascii?Q?zHD34MIkUwlamqTevRxwywDJSnGvYWzGRrQc42peMwv5VpqB1PUcuKbKuLnl?=
 =?us-ascii?Q?T/e9uK7uY2BZ3lSMxMS7WQ3KOlQoUkch/rwrD/TySSkHww7jtOuqoZQf4HHM?=
 =?us-ascii?Q?jqOjDo+OMVqMcq3helx0Hd5A5YhXjiPfQkxInX88pisEVmRYrqmZ3Wd/C+l/?=
 =?us-ascii?Q?YzJTP7ro0HvNcOukGF7mIwPurp3utpO60vzihwtSZJAZyo6NIhEb+QdzDO+J?=
 =?us-ascii?Q?eqCgO9N8yE7ls7wmW7DCZ7KXQN33k3EkGa+tBy3eqsHiFY42AEyRP4zJ0LNG?=
 =?us-ascii?Q?4PCXJXaD2z6XOD0EmgoYRiuj1pA0+sX2crZC3iC3c7tGisBpgPe6lomuica5?=
 =?us-ascii?Q?28XAR0zuGK5q3w0XwKv/cvd55nwC66vGWnTl4IjWlbXPdBJkGG+QCDn+FssI?=
 =?us-ascii?Q?4EmQzq/+NsivKi+bLxbXKTN0+0uBXcn26fyYq88u24MAA2hYm+O4b8eVLYc0?=
 =?us-ascii?Q?ERgrE7/z6syTQVjMfAnNDPLPcjIYCm1jFpgCeedLa+9MIZhcovBtnASbPSR6?=
 =?us-ascii?Q?2h+bWkVWmNTXalf3xOI5r4C20VQUH2hyLaYqFkmw5zQY/P3ni/LFiKsccSI0?=
 =?us-ascii?Q?JpawQyo1zT8HyMzyUUjJHl+JOxzaLWFm43D/pUqfjvSr4vMK92I2YsPB4/CR?=
 =?us-ascii?Q?DLswImEF83k4o5gpE+OQ+2HQyHGqpYAwfn5WDdcMDRjR3xoED7ehtbjAEelF?=
 =?us-ascii?Q?HCK+yR+quxd0QPP7O1uSPbJoQxaHkKV2WuGh2NlAnRJFKBW7PeeNtYN6QF4W?=
 =?us-ascii?Q?TzvxXERjkoI0yMfjac94DqS+v8FCrJwJetYdCc3nDrDbYebEg2aoD+nVX83G?=
 =?us-ascii?Q?kTpHQ+1Ow1aD/y+p5QI+7Pt35hzQaFe5b6QwxE1BPYQBRIk28JB2KbjXGtnY?=
 =?us-ascii?Q?qU1rbqbLD4VM3fHKXjKOWl9jJbM5CTckDzfDL7snUSgfYA1M1siFWL5Hzumt?=
 =?us-ascii?Q?JgSFb3nhSs/D3OFNl5/rimjfhpn+hqAP54X1LHyHxUzF9U7XKHoLIQBeg475?=
 =?us-ascii?Q?xbb9xelepPVvLtR1/0ocBUcdjpWTTeQfyyyElYqpRRl77Jn4DkEvfLV6mfeN?=
 =?us-ascii?Q?clrgsPByuah0FY9hzXv91jMrkq97d4bmsaGxcBCxGEXu66pvCb4bJVpjuMyd?=
 =?us-ascii?Q?MOnsliX5obAMVrYUsqYBa0Cgu8DYzlxoF8OZDvppb2mwYQWc9niyGAgfRunt?=
 =?us-ascii?Q?FMF7R6TCERQvhY7ldIqnYw2GgAYdd9YbZ2PS+yPBr6LNRRbYyyHlElwPsfva?=
 =?us-ascii?Q?AzRL0WGW+fk7nMst8UDmfQOhr6lNMYfcyATSzPDXlpL/E/KrmVNwSHLKhZ3P?=
 =?us-ascii?Q?pfFNX21wua0OAdncFFG/7WJJQm6fyAeb6WFWdqFEZ7QMvz/Iqs+nHgN2hn38?=
 =?us-ascii?Q?mDQjniRXY9tgJRolr1nXfr4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2E7B2ACB49970741ACAEAE5AC37C08EC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 63lwII0thxlqAXz7+aw3BOp5xWQ7XLfcpUzOHMvvIa1kOZYtX+IPPLbtN7VuM4YaBY9eo6dNhFjzrDg5tXVQvikjqrRhU54akGM0FTTMnv31+Ffl4sDu21Txie5o8pr5wXApWsOXDdd9RUMvBKUauOgMnPUEdbPEJ/LkcGwUH76U0/GbtaLqZAcy32LjbG0SBEFP5HLBrcjKqMoVrfBBDZ8SiJlIxyoU+70Pw/RUrgRosXP4SpfO3gh+MquppztRelJ19ajSjU6KoiAS07tvut0G72KRTANQuuZol2WDcLpsLjnanNgE+eW8xoiN1NhwymVJzb5COZaa4wbGt71+6rD/muS1ZYJn0SZrqh2q9nNzfJCp9H+2+yPnON1R3o14t3EW1dnqyNE09k3zCZouub+GHZLVHuQ1rsU4bKbkACAdJwb1isfrHuNCLWFBRjd3xs3dlFfH+W7uedTD3d6xYMGt4W7cfWwabAQFjhT7fw4+G0j0hQZox0NzvegE3+bLs4TlwuQM8lIpSiUEsoGn3vrxWkS8qnSEOTq+ShfascUTkFEF1K67uknMRRLyEqmJhaVqPbXUqNwyZccGiDoLuEOJUjstDSvyf/4Q+I3B6UP4YQP8/7nXWyGCPn1l/HpBuK8s2MOb3JnvKSqLGRQsiXwnlus2KxyXymgHP+97AvQ/EqMeyQtX3X4pgiu2lJ9aKsV5hgLyb28o7+Fh5tk/M8WvId4yJMBiB70gtsqtMw7i6ej4HAzPmN1+7jcuS9H5KnHARnI2JJhj1Kwphp0g0mvcA9cBXizs0YcueOr+aWZEYAIvebKJjGVicOtdCOugdT3sXcuOFbNuClKK4Rv5Ab7yG1FEUG05BVGqCHx6q7UXkfDKom54bRIAi5GBNpGz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2631a0fe-ee62-4332-8fa6-08db6cac7d89
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 07:53:49.9165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D78ZlUVYj6C7a5rrmXzPm5JI2cs/TquMrMPwAQIz4r1FFkCoRcgyCF5HmzVNuC+uVahAMGG2X0GNjumBhEnfF3SeVHg6W5IvXzLfBVi/r4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7123
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Jun 13, 2023 / 21:07, Leon Romanovsky wrote:
> On Tue, Jun 13, 2023 at 10:30:37AM -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 13, 2023 at 01:43:43AM +0000, Shinichiro Kawasaki wrote:
> > > > I think there is likely some much larger issue with the IW CM if th=
e
> > > > cm_id can be destroyed while the iwcm_id is in use? It is weird tha=
t
> > > > there are two id memories for this :\
> > >=20
> > > My understanding about the call chain to rdma id destroy is as follow=
s. I guess
> > > _destory_id calls iw_destory_cm_id before destroying the rdma id, but=
 not sure
> > > why it does not wait for cm_id deref by cm_work_handler.
> > >=20
> > > nvme_rdma_teardown_io_queueus
> > >  nvme_rdma_stop_io_queues -> chained to cma_iw_handler
> > >  nvme_rdma_free_io_queues
> > >   nvme_rdma_free_queue
> > >    rdma_destroy_id
> > >     mutex_lock(&id_priv->handler_mutex)
> > >     destroy_id_handler_unlock
> > >      mutex_unlock(&id_priv->handler_mutex)
> > >      _destory_id
> > >        iw_destroy_cm_id
> > >        wait_for_completiion(&id_priv->comp)
> > >        kfree(id_priv)
> >=20
> > Once a destroy_cm_id() has returned that layer is no longer
> > permitted to run or be running in its handlers. The iw cm is broken if
> > it allows this, and that is the cause of the bug.
> >=20
> > Taking more refs within handlers that are already not allowed to be
> > running is just racy.
>=20
> So we need to revert that patch from our rdma-rc.

I see, thanks for the clarifications.

As another fix approach, I reverted the commit 59c68ac31e15 ("iw_cm: free c=
m_id
resources on the last deref") so that iw_destroy_cm_id() waits for deref of
cm_id. With that revert, the KASAN slab-use-after-free disappeared. Is this
the right fix approach?
