Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D692F730C55
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jun 2023 02:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbjFOAps (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Jun 2023 20:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjFOApn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Jun 2023 20:45:43 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9D81BD2
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jun 2023 17:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686789942; x=1718325942;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mTgNyvtT/NfKrvwFIALIsOSbSMvS11S4kSSbUHZLmRY=;
  b=m4n9zhE4PISIg6XY/mXI6l+zv7gXK7935fcSG+5z/Y2WWnOQThx6phNb
   +oYrUEkNv8U2pxZPWkoWygGNNKOeNnJBFh3HZ1yCkFpcjwR8N+EdqTjYc
   xIBFF/kUbp9PrAtr/mQmHWNTRjkVkyn7rX8ZckW1nDa7bnGIEau56YT8C
   +HAHAjjn0NWdFMc/xvJ9GQoA/h9teW5f0xj09LFzArAcMx4W3KufNZr5e
   9XxAaQmP/TV7y7Yh9zHXkPAr+QoL1cJqpsrjfE7AoHIEJI5sbq0sfrrHY
   x6SuWkyPe27BTUQIXrJAoivn8XMmAJptD1KxJ8YgXeIfhpD1GTSDrEtJk
   A==;
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2023 08:45:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rtl7ykndz3gEJxfu8UhmZk8xxaz+cSKQyLdQsTfNr75CFz4rxPPlpJq7Oy9ykrheI06NzlAV3pDV87fCbXM7jncg2vO2hGeawvwoqGgjNoshF50M6OpXj0Ujf2IIaQDX6Z9bfcknJhvH94eaHxU9Bgq5zJ+JEmn+d2mQdgrL4F1wQzvu0XmDhDjdXwORsr2BGxcMQIc4ICWkU7hlXW7+0WNFyXVQBM15ub28QAY7UQ/xU0Nu2VBpJkmbDxojVTPcnJnPuLWzniTk8CR6HmZN/nUunuR5aUbnb3OwSWGuCgUuVPRV0ETo44UhhQssmwwYJ4pr0gXw/ir+O1xpP+lbfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTgNyvtT/NfKrvwFIALIsOSbSMvS11S4kSSbUHZLmRY=;
 b=mWDzn3J+EtPeKFEAy2G6vHuJgp72p0wCE7cNZj9yFWeNrg1hPiaiNbuxbtXaHHlaHh/kcHHnnTFQc1miAL4CC0QCkh/NDa3o+QP/2+ncR20g1caD/k7E9mVe//fiQwMV2wVsAQYiQIZrnR4020lVWAqf/ICcm8H2c827prV2nwoPIO8iCPMozckYFBceP3vsNIjN3KJC8Wz/IJaVRcl4onYCsfUtA7W3vLzPrFpSChDmfE4EzSdZ1zQLzhciqE18OYEEJB3l9NjEJ9vP9p1Q2TZZeuklcg4hgpgI3jmm6N4lDtaJjbg8LU3Mr1gIEkTzXU98noAAXPFgoMYlslBL+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTgNyvtT/NfKrvwFIALIsOSbSMvS11S4kSSbUHZLmRY=;
 b=MHIuWiK7MmR2ZsO8WTZ3iTTQ7EliofKLi6xRE88QUuFbwdJDuu7c+4VL0thMwCiqIK4kAEcq7rY3gY3q/7fHyCn5DTjd9eRMx3VGU5if35sL0HtxtTKt4vRvjif7c1QdIubGOTBg4+/NwGZMQctCjNbp5BvQNHLKeTNupcRh4M4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB7749.namprd04.prod.outlook.com (2603:10b6:8:3a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.40; Thu, 15 Jun 2023 00:45:39 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%6]) with mapi id 15.20.6477.028; Thu, 15 Jun 2023
 00:45:39 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2] RDMA/cma: prevent rdma id destroy during
 cma_iw_handler
Thread-Topic: [PATCH v2] RDMA/cma: prevent rdma id destroy during
 cma_iw_handler
Thread-Index: AQHZnPC2s/8x06ig6k2H99zVQRnT1a+HN4aAgAC/dQCAAMWdgIAATXGAgADmt4CAAKMBAIAAd8UA
Date:   Thu, 15 Jun 2023 00:45:38 +0000
Message-ID: <l3gjwsd7hlx5dnl74moxo3rvnbsrejjvur6ykdl3pxiwh52wzp@6hfb4xb2tco3>
References: <20230612054237.1855292-1-shinichiro.kawasaki@wdc.com>
 <ZIcpHbV3oqsjuwfz@ziepe.ca>
 <3x4kcccwy5s2yhni5t26brhgejj24kxyk7bnlabp5zw2js26eb@kjwyilm5d4wc>
 <ZIhvfdVOMsN2cXEX@ziepe.ca> <20230613180747.GB12152@unreal>
 <iclshorg6eyrorloix2bkfsezzbnkwdepschcn5vhk3m2ionxc@oti3l4kvv4ds>
 <ZIn6ul5jPuxC+uIG@ziepe.ca>
In-Reply-To: <ZIn6ul5jPuxC+uIG@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM8PR04MB7749:EE_
x-ms-office365-filtering-correlation-id: 6301e1bf-88fc-44dc-4b64-08db6d39d6e0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9ym+B7aYhY52knI1YBlJDaprJccshlMfKxK04Z5o7Jvk8GUSJrUsAcCKmm81azDWkOYiVH9jY5WhcHz58AS8DMnlzlMzenXYwHziuGoUkqYRmkIkdjEhvZnK4Hg2YO5FDrqUPydgHjzzMmryPzH5LDdpTBPV5j1l3kMx0FDaHHPtzHhLbL8890rr5mNqMbLnwMV4TAJUnf2+eXfQ9bv8RVRFMIJPkY7O3rA0pGRkqncpJMYQ09s8eT2llY4+LSE4Ix9LlSJheBvY44Iunuv2WviHP0O0lodaVjUXdK6kMZjtbQDDBO9kUAlJggwpY8rOqpJC+BV9WfT2l4iHcnsUFBrziGiTglgOc4IO4kystcEhW6RwmuEOIpuKY0Iy2qMdZRWtnU2s2Em5K1laCyUv/Y9bBXXSDGY8R8lBWHqqTEdayP4qsRNRhsIMdjKU9l+6Rh4nzSoVpEOvY9KZO2JLDc8Kk6iIuwVHJ7vGucfAfwWZo+e1T7BKuKyCoO/9LuC32NbCVhvtIfaAJXasgOEKoIOX8KuYk67OO9kZboXQooiMLnTbFw/kH9v+K0tkhGpJH3awd49psBJNcYnp54SfA2dxuLfRUAwL1HobyolnemRDKfgnPq4DvSuBZj5XqPfD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(6486002)(83380400001)(86362001)(38100700002)(82960400001)(38070700005)(122000001)(6512007)(33716001)(6506007)(9686003)(26005)(186003)(4326008)(2906002)(54906003)(478600001)(66476007)(6916009)(316002)(44832011)(91956017)(64756008)(66556008)(76116006)(41300700001)(66446008)(5660300002)(71200400001)(8936002)(66946007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EnJrGD88eC1cd3sBMp0wcZG9S3LIVAHxG9p7oBHSO1HJmQqaQ+1zw9pGPstd?=
 =?us-ascii?Q?Zy7Xcbhv01kGKyVmeIHiNsKLMjGLYHfdx3OCm6dTEBWFQigCS5OuTMmUnvIB?=
 =?us-ascii?Q?jI8xL0hExD0h8ylwO98Xe+zjbflSrnoXoJ5L0ynlz9KGmp/uPhy3ULJLR6Yh?=
 =?us-ascii?Q?+d/hLoDUPJXx0oJWc2gABCzHaTXK6FPPon/hxN26TlbKj2PE8P4L7G5OjHvv?=
 =?us-ascii?Q?GiBdq0rmxLzJKiaD/IGfJq8SqavfZtQDlzghcuwGm1pucfig+xT3Y4i3MtgT?=
 =?us-ascii?Q?ZOhaD8bnDoP8SOuR6j1SY9SA0hOOTDuFL+Equ/rL91C2tSY3Rw4iVRsicjWk?=
 =?us-ascii?Q?/IXcqQf6pKHFMP9Vlhm6BVqg89PKxZgNJiM03CrzraL8zvNaK3/ofcUpFoTq?=
 =?us-ascii?Q?wNpYQxeCCY+IWMUWrxWXcQVlgTv/lKOATwoMgjW7GLqjenE68SvvmLBiZyus?=
 =?us-ascii?Q?UhTnADgu4FBIVPuMJcppsnJTAuC4NKUFF8WbKr67djn7jMU1hsYgeTEwOKDe?=
 =?us-ascii?Q?NGccnaSTv7BZ3dKbhQIqWfsr7eOOMJVS7rzmCnq1nAAslwOzqtrVTH/SmG0z?=
 =?us-ascii?Q?+ONw7ElwsUyqUJnGKib+oV9lYIJtCYyxRjCyqT2rPvHrCsDYdeeJrQU3JrUk?=
 =?us-ascii?Q?n8NV5+lxSZzteiweHNr1kIBIEmNhEujJ9BVG4Emt4qK9HICYWqnFvaNUZbXR?=
 =?us-ascii?Q?Np/Xq6ZZA2xGfJ2ygN7C7pktf0304VqC8aNBDa2aL7Lqx6TF3BQvrqleReo1?=
 =?us-ascii?Q?0E7KnrxD/ODBGzjDPBbECqzxfB00i7yUZFPmjwZmXSC7BTG6JPawIVwsf++x?=
 =?us-ascii?Q?8geHhFkbN2itjIWjQMmtyxOze07fJK74cuAJFldWMsrinHlIA6ei1+4n8lsU?=
 =?us-ascii?Q?AH2ochlXxRRLpQi9WlhU0YUMOgaHUntO9+e8IDg2X1J/jahvR/K40uteq2Wr?=
 =?us-ascii?Q?XaDIt74oOKYT2Mr6kLS1NQaf2qOgWQy0BUYrhCCtJo0a8FBYRuyu2x0yPFzT?=
 =?us-ascii?Q?FM+Zc/YXARSXJRPb06K285kAJ/Anc2PKGrbKL/ctZvMICtrel3PrVqBLM7iA?=
 =?us-ascii?Q?UHQnRenzKgrL+h9WBKgFntq+g3tWI3sN3HRtQkwTd8af1jO2PImAx0i0oKgt?=
 =?us-ascii?Q?SKKMMNa7U56vfXCjG3sdySbIS6XXK/Lz0L856HUt2Psc6kgGVmulcbkYw/iK?=
 =?us-ascii?Q?0a0fgPvWjCJtfUIwHdi9ymVMnIrOeEjW7u/GPDwbYzYVk8CMslcxIV5TVi1K?=
 =?us-ascii?Q?qm8N93Wkhd49EYlDLlqy8n4k+XgitREvVcRMz0jxygNHCdONwDxyuUZDkv5L?=
 =?us-ascii?Q?RTg1ln/aP2fJEZsAr8dv2aqZ/XsKN9Q8kmOnlsbNUJpz4rvcGngXmCjDUX39?=
 =?us-ascii?Q?0jBrCcwpkW3atUD9LU61L61GwP7DLUrD3RgyrGloGhorf80p1t9tc5fsZlrP?=
 =?us-ascii?Q?rWaoV8VsXWpsE0oAL5vbjD/FNhDEhrpQnN8NW5mN1zRpoME1Nng2cKE/qpwG?=
 =?us-ascii?Q?2dxDroIQHBBC5btCV/1qLyFxxq+FWptfpKslOP2G2Ajkzy+H+kzzZzWfMMje?=
 =?us-ascii?Q?KEojN4dV0Kx958ZM18YE3kwU94tWCY0iRCowQwH6L7f0YENZfGa+md/WL3mM?=
 =?us-ascii?Q?mdDPrpyiOLNezScLG13C4gA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D3052FADC7EB314F87EB339073AE0B4D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pY4btOtV+s3AOE8r9DmHqsSt6kYhlcpb3ehDs/OUns5n9aQzhr91Sq1YpGr7nG652d0Hy96Mu7aVbA6Cf3k42WAEwQcdUcROPDLTUlEoSubhhZ+4swgEZ0M3biZwe5uNzMUXD3dVKlOlgyV9F194Fnv3z0sjoCLuaKNuZiU1JA+c7gYpyjp7tvGwwFGQbxpXLYQGZjBG6sY241iivAS8c0mZmerKeDZNcW8eJ4mFapgK/xs1tIRT2va5licXUPv98xA/putBejh5NroT3yVKfIxRVnYYIKYiF55tSFwwU+DKy+H/yAyiKX67qGt4S2VWObuMsyvE5hlfyZD1gAbVr5QsNg3FbWCmBzv+88F+orfm3lIbUy+vq3uNkij+bwXP9vYbpS6O+N3zz9X4CAs5ISwvI1lZvdEI9J5c90rO9kHD/BfbIa1jWCcaa25A224jZXXCNgHQWNxgElLEKU5UqCV6FPNiGAfgoeaV5TTCUOxRtz+WiS4sa2eMW1LvCBpZ6POUG5t3HTFxW3w3nV/eRI7kUqFm0MsGIoH6r0bVxO8FEi6cQhjaaexNySYiz4f7Jb/zEtKlKMR/qtKMmUCKCM8As6dlSs+duBIURTJDM/LRLsFMbsG6tlrQOE4Q4P7PSq9I70vgDszPs/6Q01Uy2+im5shAgPCxkEeeySmYQian84DwWRII3Gt2tiFTWPT1uWNGUscX5q1GuQNR/gNJCmVCjIMhb6T1nNnsvy9cncumLruyNDpaQvrUTvKHsZCvXCvKNbpvkC18YzlBpAOWt9sDUiyMfcHXK0FPPpW8KnqLYSWWkkWgwoKuQE+GimZZT4L61/nXTzAhSyII1fL9SO9dg+dT+rH6IhJ8rSGywJSOZSTd5wDI8LVjSoffLbybgtmCxGuIc4DktwVeuD87wg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6301e1bf-88fc-44dc-4b64-08db6d39d6e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 00:45:38.8310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WhBtIKwcZs9zVqtVQh6ormc4PLGGZWHUtzAbysxcG2QuohkkRtq5rruZqHOWKFuLethtT3Q7wB8klFp0qGMBS4keboxBj1vm57t4BprKCrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7749
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Jun 14, 2023 / 14:36, Jason Gunthorpe wrote:
> On Wed, Jun 14, 2023 at 07:53:49AM +0000, Shinichiro Kawasaki wrote:
[...]
> > As another fix approach, I reverted the commit 59c68ac31e15 ("iw_cm: fr=
ee cm_id
> > resources on the last deref") so that iw_destroy_cm_id() waits for dere=
f of
> > cm_id. With that revert, the KASAN slab-use-after-free disappeared. Is =
this
> > the right fix approach?
>=20
> That seems like it would bring back the bug it was fixing, though it
> isn't totally clear what that is
>=20
> There is something wrong with the iwarp cm if it is destroying IDs in
> handlers, IB cm avoids doing that to avoid the deadlock, the same
> solution will be needed for iwarp too.
>=20
> Also the code this patch removed is quite ugly, if we are going back
> to waiting it should be written in a more modern way without the test
> bit and so on.

I see, thanks for the clarifications. I took a look in ib_destroy_cm_id() a=
nd
fount it does differently from iw_destroy_cm_id(). I guess certain amount o=
f
changes will be required for the good fix in iwarp code.

I stop my fix attempt here, since it looks beyond my bandwidth now. If anyo=
ne
provides fix patches, I'm willing to test them.=
