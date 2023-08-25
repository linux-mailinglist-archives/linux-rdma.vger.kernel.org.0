Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91102788056
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Aug 2023 08:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbjHYGv2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Aug 2023 02:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242699AbjHYGvN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Aug 2023 02:51:13 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B845326BB
        for <linux-rdma@vger.kernel.org>; Thu, 24 Aug 2023 23:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692946239; x=1724482239;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FRnRppzGaB1CL91GqDa67Zw6AI2mAmxZeABqJru86R8=;
  b=SLMy3dPB6uSYCgh8qjaEOtAea+s2NQ5K5/i+jhLgnfcsmy+Ca52de3QW
   x7HtqYktBbKVTpZF002aC2pO0ZJsiaUXRA++qc9yUHc0IAiXim0lf16Hx
   gBSJbFI4iGGECmkbgr3cD3oyFZXzFjJFAfg2vfRsDmo8MryBJJ7QijO3S
   2oQkEVi+228cWAu/ZYcc/0Yk/4MN8m5MPfXz7JOzWUr3w38r7S47GzzeN
   MeP3Xt8qDpASmBeIXjek4o/j+X8nF299jJGz9LjV2RL9dEV2b+MTWHST8
   Bfya4fibG1tXVxZedGLKEuHsCvKJzr9LJ++MQx813JUIOmwcDR52Dohcx
   A==;
X-IronPort-AV: E=Sophos;i="6.02,195,1688400000"; 
   d="scan'208";a="240331617"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2023 14:50:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiRoN81owPHxBlJSirPXZiCtFfxxZPD2yZ1TfojdgiCU10jn6fsyN1Dxf9tGJKsUlc7aYe5OGFmV2YqhPKHu3ySQ3z1Dj7YuVpRX1NsHyz9/IWOr3ytirwtYZLjsyXOXuW0bAm2c68a+ddpZY6JdweIbL2sOx05PGZsPSvy33SQR91mb1H51wVN+ZTLnSkrDsALnOvkn97QLNnG/v/oV1V8yAKo5y7saTV4QXXg3Vq6ltX4ur8TZMudJhAHLp5r+CW9UqVRC7mYUE5w6zV3Q8tSJpV1uBNEsUWRT0f4g0SUy/LykFXgYpIlbTFq0se7ehuK3ht9LIwi6FX6pQaEDPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRnRppzGaB1CL91GqDa67Zw6AI2mAmxZeABqJru86R8=;
 b=Vb06O0wOCz1O1N7oRLS1N4XM/uI1X9carMX7dkVvAH7OZJ/ebd54dkBzAnf6kmCkVsyTfCYsk2uLxxkvCt6WG91UdN0ECZa8B7Quw9GJ7RXW+zKjtEwsOV20P4ylrbtoISwdop/JKCAgBQBVoLCZ04zsibqAk5tyfDEvwg4CuMD8yiondUi5qQAGmh/hGqxSQXMCqNuDWmHAAdi+QfQSaUN1YhJXoNUPReERYlT5ZqpVHyVQEHZ4+UcdWpmqoDo+X0H1bj2ousMRs7ra1egamBhHx62DEq2LTmTcI2j/UXlfgla3ktfb9CGUL0ksDEzXQqTcogcsNhCFNTt6dJc7dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRnRppzGaB1CL91GqDa67Zw6AI2mAmxZeABqJru86R8=;
 b=h+UFqkzi4BXiniC9m2jyiKv9RrNpQSbJokwtfufsdivoO+hUo4EY6tFNBABZvjSp24QgsuW3TiICcfLj97WP8OwuF7ECpqHDr6qpJcFcKUNpGLmVH3VtDjxFM2ZWhXcmtEHvjjL+uQNMk6RYH8NlTs7DEDR0ZWS+yO0qu67cdFM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ2PR04MB8899.namprd04.prod.outlook.com (2603:10b6:a03:542::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.17; Fri, 25 Aug
 2023 06:50:36 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6723.017; Fri, 25 Aug 2023
 06:50:36 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH] RDMA/srp: Do not call scsi_done() from srp_abort()
Thread-Topic: [PATCH] RDMA/srp: Do not call scsi_done() from srp_abort()
Thread-Index: AQHZ1gRzHi/k5w+wmU2RlWkdavOUQa/4vi0AgADG+YCAAQ+2gA==
Date:   Fri, 25 Aug 2023 06:50:36 +0000
Message-ID: <csdpyg2iliydqtsrwtkcryj3g4ng5elkchv4frripnvj3azoru@xn4ladyb4ti6>
References: <20230823205727.505681-1-bvanassche@acm.org>
 <a57g4ywpwsldusg3ow2ci5nviikma3p3fcoqeatp7pt63fe2tk@xgisoxtde3tp>
 <fe540444-8454-4d15-f279-92daad4be001@acm.org>
In-Reply-To: <fe540444-8454-4d15-f279-92daad4be001@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ2PR04MB8899:EE_
x-ms-office365-filtering-correlation-id: d7e99ea8-fdf2-4167-b748-08dba537963a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9mmxnPbfHzPXzRDc6UsxyxtqgR1SkNwN0SUdLYO/li7064cBE5gu6thVqAM8SK6WDIBhj22owYGsntbpRn/hEEfDclhE7WkLBWPv7aH7Zhcpq4hjw/lD2YwK5Pe5k5HZF8045ep97wWtjtatlb/dyDg2CE6WsmICongOLTnNWff7wdIuRdDzNGx6epYYkRJ4FFakHbCY7CXcAsvG4FyfX3nyBf8dqFPgVq7hMFoS0VSMOo+eygJsdMuBC0lJYAUVA5jOTcPDVgkD/p6FJfsFBw1tfZeCUlYO0HpN8fNEYkc2ANYtkVkDIpHaOxdkzQh4nVhKk3iB3kJJqnVfYF0vFrVc7Jb2kNtjbxod2FayCWnenuFer36dzmsUbPEEhMtRIXlJ4s/pH/0aS048tFKvstOBt6Ix2D81qt2oxqGwQhqylFNPavwvngXa8RGifOC54Om61OaK10M08MghbuQxZQbhtozOEmDfS1JBsHYmWennXoDm/REURX21ElHTjscgreYkcXbwaDiym0cvs464bnoNlnBAm9VcL0+D25x1MPwVNG46QzrYdGyAuh+nyE264f/nyBvnXR4Szl2ATtAupnG7YNzQQKglcUnMhGzu5BU9ayBGLryHwm19+DxBW27g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199024)(186009)(1800799009)(66446008)(54906003)(33716001)(64756008)(76116006)(66946007)(66476007)(66556008)(316002)(6916009)(82960400001)(122000001)(478600001)(91956017)(26005)(44832011)(38070700005)(38100700002)(71200400001)(41300700001)(53546011)(86362001)(6486002)(6512007)(2906002)(6506007)(9686003)(4326008)(8676002)(8936002)(5660300002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rBa5Ex844QEX7JiAE/5MVCRMb3cu4yXaPjs0474OMqixu25zs5e4vnYDz+g4?=
 =?us-ascii?Q?A/uZEMLekjXtY9DKX8UPnOqBGAlfd0vf1WvgXZ9s+dhj72DTSXnm3rDEMwjc?=
 =?us-ascii?Q?PUFiadATL3/DneQTUae0MC04XpeBw+k/fbym3fHkrTEUkG/m0dvYj5KqhWwr?=
 =?us-ascii?Q?Qix3cNjD3xbkcw++9ao3JYGGGoks945Ja2DBAblRA7tCTWo1nt++MBLq7JcC?=
 =?us-ascii?Q?8iQg7UXNcL5YmBuazniacC4c7QmcmJoFnEYfnge4n0RdhFjUq3kd7EyTa06h?=
 =?us-ascii?Q?z/8TVpXEbTssFoF4IcC1F6KsINU6qL5Pc4gnIlw1v6AtEHHFWDKOEjk0czTU?=
 =?us-ascii?Q?OWL/k2vy6k7RZOd9xNKPFRpRqUeHr5n9n0t//LtIYn34nxkGrfiYxLwPqFIw?=
 =?us-ascii?Q?bJhz0vCxOVRtnYcdNxvU5keje+rw26mR0gWzcL2hADMAo+gOCObsJLNW1b2W?=
 =?us-ascii?Q?iL3tXVAxqfpLyuW8h3Biai6sGhd2LEBNW7+/j7zp/Lz063jknAQqVrGicyRz?=
 =?us-ascii?Q?viDv9qDyKVXbBnLYKEKxeexdjhZNGR/ZAakRAli7dmsL+2Cz71sFVuVawNLC?=
 =?us-ascii?Q?mhK+oYfBCKyrXUs8PVZ9g0cUkAbvdDBMXFsH6LrmUmY2PnVVkQc4I6EwoOwv?=
 =?us-ascii?Q?rDifhlZdHaWc72a904/FjhrZPY6gtaezYyVINfwc9mf2ReiwYiUCC8heSlmB?=
 =?us-ascii?Q?r/hQhyJiWIuob1LOoP9Dy+e4AHAaHIW1wsUObfKIZlECUsPVmu0dX5ObJbcy?=
 =?us-ascii?Q?aUNk4M1mWmBG5k7d9/c2ZAUzIDHn+DH/Zr+Mz94jT6IBNcec8IkVRMz0juzz?=
 =?us-ascii?Q?jUhnYbWIitXt5d4wl/ID0Wst5cjRHPuznXm4/oJSE3yTwv7S05mviinLiQUl?=
 =?us-ascii?Q?ZY1fZXxU/UxxpzLGB8bL0h9pEo7X+X0j972J1ueEgBI5pH7SGFAXmoKP6dIU?=
 =?us-ascii?Q?3nV8zX1u1PD40UcacBE6m1chxy6Vzg7H8Ycw6MBGFLUXpxzgQeZ8TPFmGAoz?=
 =?us-ascii?Q?RhB2xQ1ELFvUF6PPPLs2gtcjjGIf4j8LGScHesVKk/L53QYqiicYr74iGSzH?=
 =?us-ascii?Q?spMvGURbwzv5a12RS3xn9AQ4LgtnEwWsVt8a9BtBHycHvd29O5CEFqJJMiyt?=
 =?us-ascii?Q?kDMfprKijij8I4lOfnJ3TwAiFkDkrMq8XowPEfPE/H4JG9jtYidop8IiiKA2?=
 =?us-ascii?Q?o5hR6QlRvBHtxB8EVe+KQ5jqBIGLEhovTdpGcEcaO1lyP0Ubnw8bwRLoqvPQ?=
 =?us-ascii?Q?ZYnEuQUHPfGRljU0zK/NNqYOc2jCQN6Bk/TCXjAX/PqXxO/2dLheutYgat/M?=
 =?us-ascii?Q?CtkOEJZj7YM3gqqX2rXR1tr+GUok6HJu7FOq0PAPgaUw5sXRJrp8D3KbCO1k?=
 =?us-ascii?Q?cZJ5AVaigg9jloNf1CuXWy9+NXiiEeQ00TRrCVkEzSHFGFI/V8hRGvtz4U/D?=
 =?us-ascii?Q?YPffZjQXFbN7AN7RO++k9hpaFZ/FFslO0nCmIuqthZBqWzbWyIqNI4RQy3Lm?=
 =?us-ascii?Q?WE6ZNO/m7RLqMsQWvLfHnCzUNGUDWz1t0nAwbGiL8z/IUDXMJtyr6mOfpt+k?=
 =?us-ascii?Q?DWs24F1HPspwhKK/qOP5Dla6Sz60qKNVfgLiZMZUd47+rjO3NO/LVN6zKZBc?=
 =?us-ascii?Q?GvDR/TuDCbjMsfDekfu7nY4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E0A89F15E319784BBC36B4BCB76C1C7F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4PRQge04tWr8+h6/8V8Y0D+SMjp8un5Mop46C/xq9lT+4HDr2HokQw/6DZsi27fNmO9+uiZvrPaN+DqizUH/Lu9e4tjKJb+1Ga/7HSc+6M/SfZeztxcXq3rPz9PcDBAEXQJpDg31Vo7Km4XnL8di6Zn26EAsQfWxeEUtFTDqxpAw7tF6fjMnnD81qFKfuHMzol53W2Hy8iXhkBRbbaGSwwOOE0t1gpjXNGbnAvnM6X0jzau/oHvZUOTez2UX87YoqA8uBlNhFzWoKqdU11J0p4oJ+djB44LUylbkSlO126oM2mgnsVYivYoPuE8uD0+pBzIVC2n/kBP2Zl+2/S2PIxFY9peCoOSNK9ZSv1r0yYyI5QeVQD4sdBRQAseG41SHc6O2Dn6Swge5/NttWYkRvfZqUxn6IeQcsXl8QBMln5ZP1lunQvDAdBeWT5J9v/dVmj4HrWxrZc9cMeyZsK4Qa0Gk20LZGNniUFTzSe6fPvL9vnQ6UuH+s+e5vGQMhjYZV3n1k9glFMjzN5MfwpeK2PJbIvklMOEa1UNC13K5SPWMWzJHUV2wHAwWbujb9rITmikYnf8aUbYgp2B45NbWhvsxOv083xoTTJHTxW+9fXbDDWHwmiIFCN6gCXctKsjsum4602j46jr3tF+rzoeVql5JqSwN9YO21HTH4Wtw2fIoVbZTIKESGNnTdo7Iiyn53GJLOuTL57wBtAMXhwRKPLemRI+aYXtFwxODnaBo+wpjtbZETtuiu7dL/uH0nmSnXJjbYu9OMTh68NHVkWZ8uHq2eltAVwlKTlgw0kro8XpwyiaPC/evXbMA/bNHI1dKJOaTsWK+73qxVeB7LnGy2Bt+NjjUcOfh3y7FI0JXM0E=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e99ea8-fdf2-4167-b748-08dba537963a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 06:50:36.4687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rt8s31EMDHaYH/6JQISbK4sfjbmwOUzgODowB5JxVx83T6t9N+yaMQ1tMbDG/2NMjsllW1LNLkUjfvWVurhYFj6eDMbfveTy44Vxn8Zo0+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8899
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Aug 24, 2023 / 07:38, Bart Van Assche wrote:
> On 8/23/23 19:46, Shinichiro Kawasaki wrote:
> > On Aug 23, 2023 / 13:57, Bart Van Assche wrote:
> > > After scmd_eh_abort_handler() has called the SCSI LLD eh_abort_handle=
r
> > > callback, it performs one of the following actions:
> > > * Call scsi_queue_insert().
> > > * Call scsi_finish_command().
> > > * Call scsi_eh_scmd_add().
> > > Hence, SCSI abort handlers must not call scsi_done(). Otherwise all
> > > the above actions would trigger a use-after-free. Hence remove the
> > > scsi_done() call from srp_abort(). Keep the srp_free_req() call
> > > before returning SUCCESS because we may not see the command again if
> > > SUCCESS is returned.
> > >=20
> > > Cc: Bob Pearson <rpearsonhpe@gmail.com>
> > > Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > Fixes: d8536670916a ("IB/srp: Avoid having aborted requests hang")
> > > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> >=20
> > Thanks Bart. Do you think this patch fixes the hangs at blktests srp/00=
2 and
> > srp/011? I tried this patch and still see the hang at srp/002, but the =
hang at
> > srp/011 looks disappearing.
>=20
> I have not yet tried to verify whether the above patch affects any blktes=
ts.
> The above patch is a patch that I developed a few weeks ago but that had =
not
> yet been published on the linux-rdma mailing list.

Thanks for the explanation. I do not observe regression with this patch on =
my
blktests test runs. It looks good that it avoids the srp/011 hang, but not =
sure
why it avoids it.=
