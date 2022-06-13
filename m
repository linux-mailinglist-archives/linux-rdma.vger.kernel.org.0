Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A440C54A1D0
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jun 2022 23:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbiFMVwx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Jun 2022 17:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiFMVww (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Jun 2022 17:52:52 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2104.outbound.protection.outlook.com [40.107.244.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724981D302
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jun 2022 14:52:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nt5Ov7+WzW4ibGNWVjrXdFIaVGSvFTyA4CyKrUZJxBp1BEjTW0ndimGbuk6Sl/Py509cHeDRFy3CbL1q6g7OrHwuJl55nSak4gv1SQQ6HhSoNXEKtSHGqiOy2DxfkNJDDi7akAdE3CE7CGZHJGC5DEukTLo+UMmGinwiHAwNoA6XXK1zaF1rgmVy3YpnBkdgYrLeD9XyW47Um5cwMObmlb8q5hLnTr1YdEHr0dgH0tpPWHGH/1iS+1OdW1JxXT2NRO6QNM3qd4tvK7NvT6TUiitEQ46KWLKhWiotW3GOm0YClNTkRJZPx0QBrq96YtW8dpIDVxxFsEZXFfW6+vcdtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4G69DSgpQxMpPGZNYLmLMZGpQGnGJYAUUNIxsoRtb8=;
 b=TD20u61RVPWXUXGKinT1PBDZmwJ/fCrGbofElyliPJzYXDyBfqDyjOb/kiNQsss36KbPFpNLsNPQRBm+uhg/+wgujb8RUArz/jd/EbaqvBRgj2zu2EJQSiYnn9lopZBBxeBepeWVp5aB2jrMgq+37LOMWnAYRWl2S6lZOcATOR0hW7FJononDsXJoWDHFN7CrV6gLN0q6P+3hlhnjO8r1zzOT36jO13GUEyvQ/oRRkk6mqVU5WSQMwElpr2k6Ra3gSHj0OZcCpEu26PkuuC7mnZOfoAqWc+tGPVRt8YsVj3ahiLpRZjTyMPF9tJnJJaPe6GrupVpdUS/+zzDJcelSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hcdatainc.com; dmarc=pass action=none
 header.from=hcdatainc.com; dkim=pass header.d=hcdatainc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG220063.onmicrosoft.com; s=selector2-NETORG220063-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4G69DSgpQxMpPGZNYLmLMZGpQGnGJYAUUNIxsoRtb8=;
 b=p3LTDPiauj9E8MCrWW8JlLNv2rgttXbD58tmvf06AbrERwVjxdfh6vrnQuIaN9kHw99Cq8+PzoFnDYiD57UG39DozI/dPd1MkfWXvxa4iwsmR4BsIYnL6nyH4NmzO7d6YJdHKuZEv12RhYRpPOOAR3yamLq4wb5qFhlmKLDw41Y=
Received: from BYAPR10MB2456.namprd10.prod.outlook.com (2603:10b6:a02:b3::16)
 by BL3PR10MB6019.namprd10.prod.outlook.com (2603:10b6:208:3b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Mon, 13 Jun
 2022 21:52:48 +0000
Received: from BYAPR10MB2456.namprd10.prod.outlook.com
 ([fe80::9193:85e5:b0b8:f891]) by BYAPR10MB2456.namprd10.prod.outlook.com
 ([fe80::9193:85e5:b0b8:f891%3]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 21:52:48 +0000
From:   Meng Wang <meng@hcdatainc.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Fail to establish RoCE connectivity after restarting network service
Thread-Topic: Fail to establish RoCE connectivity after restarting network
 service
Thread-Index: AQHYf2vnHwMQ/V+cjUarABYifdpfgQ==
Date:   Mon, 13 Jun 2022 21:52:48 +0000
Message-ID: <BYAPR10MB2456DF1114106F49AB1A1A42CBAB9@BYAPR10MB2456.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hcdatainc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac63a3e3-1de8-45b9-93c3-08da4d870e55
x-ms-traffictypediagnostic: BL3PR10MB6019:EE_
x-microsoft-antispam-prvs: <BL3PR10MB60196531EABC513547FBEA85CBAB9@BL3PR10MB6019.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7IqkVVhBfV1mewyr2jiYrmZybYgfGauBdlCcbAKr7qVfQYy3OooW+nuhrSj22s4ZULm9+8eq0i6a/cL971qKSdA/jE0J8gPdtScwDCagLyLOthLkZOUihsnTLRTYXuXjnZCK9AZurj4cCSubu0T2zPrb4J+wB/4JgQ6fEh3sf6nmd3G7DeHOJ4+C1H/RYiUeCwqhXKYL6QBvyNycIOWOashtqJ1XGDN02ANQdyKeROpbym/7SBEbD6tIs1FUTq0JYmOdeybmoHkLtQEf1iXGqdQaNb0HFQiS/oVE6FQRlOEli1HbJdeuBT8xnXaPYHHDfVsEdIDWDEbTtW/memy3B39WQ2ol2zFQmSgh7/F25AT3HtY/4186DrqTw+lsjKNR72oe56OeO9Suc32cWed8tt0q2zm0wb9rN4YTrEwI/KMI7I8/MqKZdtSTv+8v67rKUEb/IsolyxdBHrfL9L+OUmR4Tp7q6GMQMVilxK7kKyiDM5259CbG1uOb1rPi382/x/uFQ82wwOOeqVw0M1RqXYeSrmPhDPYLIaLnCItDNq9CCre7BfB6vMs855C2dyrN7/DwF2fbfuKf9833ehZvRY1Jyc1p5eTIdNWTuWg/I7JBnMFmzbJhJsIFR5jwy7NjH5O1U6TiTZ8EBH0UPyiJzIHsl10d8l6IqR63rvUrcjSrVymB5pgNyAJSBBz/stcWOADG9X2KqMdHobP1wNQqoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2456.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39830400003)(346002)(366004)(396003)(83380400001)(71200400001)(38070700005)(7696005)(55016003)(508600001)(2906002)(186003)(33656002)(26005)(5660300002)(6506007)(86362001)(52536014)(122000001)(38100700002)(8676002)(6916009)(8936002)(316002)(9686003)(66446008)(64756008)(66476007)(76116006)(66556008)(66946007)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Sl041oDZozpqTv2+K+ttCJyBh0+bVKoqTxUk2DXu866TMlHKfqC01FAelS?=
 =?iso-8859-1?Q?wwvAx7EXHyx4bLQIYdgqKeOIO9gBgTnWX5E2VoJEuKC1XpGb/EtUF3l/bC?=
 =?iso-8859-1?Q?40F1exBU0JJBDgs6WMXzJqYAcfci3br/BpkwjVQuzVrkjoPhsG5AtVRdpt?=
 =?iso-8859-1?Q?sUwTNuTjz8E+I6wrlZ7LnsFmS4hQ7q4BKZHnqNMt3XBrHWyVXGiVhAJDCO?=
 =?iso-8859-1?Q?7OnhvhgOtp7b1l6/eM3UvoZwYYJA+FUAqkNyA21c8AFf3fcALwPUA6YZom?=
 =?iso-8859-1?Q?z2jqK24Rvp26WwA7M7Fqkzvo/J+DXzUbXUPEAnLaIVCC/v8A8hC+QIhNy9?=
 =?iso-8859-1?Q?SU5eZw3xaJWrybg8ob2Opc8YhirAcysjlNbdYxAjDXE8LwQu+w1TCcYMKZ?=
 =?iso-8859-1?Q?Q8/oweXMJfsju3wBCD9BDj03U9dzZJrkF0ihonHm29uDvOtAY0yXGPEB1Q?=
 =?iso-8859-1?Q?7T/10Okmj9R3BUGXrGYKjZ/+bLr9tlyignZB/EQDcRUsn17IuFIXTM8epO?=
 =?iso-8859-1?Q?3ps4Lh7zEYnPO/IsWpkI9rscngWQNcUWXCR6AAJv6RfmTFwrnorg+3LdGu?=
 =?iso-8859-1?Q?vtmKRiAdlxUgxLt2a2bhBL7UTxNWhP2V0ryBtTjr5kUzhnBmEjn/D7Wuqt?=
 =?iso-8859-1?Q?7gdAx1uDIg2I//4S5qGcuqJPU8d78VpRSN2ScOkaxWdX0fJqwsOEahBvPD?=
 =?iso-8859-1?Q?oOagW0qwYke+BKI0mULXtetTHIm8RXdUZUDI2YCY5Avkzgzy18gDzPzoDA?=
 =?iso-8859-1?Q?0nG4LgFQQhivjC00qLsLxbDDQV4gSRSmsKSXDrG26qbYOhVsyL8YFYP0Re?=
 =?iso-8859-1?Q?Z2j3yE1qgLe/ZjtMuZ8wzc8KegTWw41YaBdv5wkr/kO9zPVgFBOT/1zHsd?=
 =?iso-8859-1?Q?4ajTxAw8lELPyXNrNcrbt4yQ+iSwjpdSeXenCbi9xIHp+umEd5sX7S0c1p?=
 =?iso-8859-1?Q?EJ5EmlKdqY6NF1lxVgRjiM52uUXNe1u4sPeaIwpQnfhZ/z2nrUEuam7nCf?=
 =?iso-8859-1?Q?dudCW51PTVEY5m/X/hEd/Im6gUADgskrigbfVkN2woHo52VyIAnDnTb7hx?=
 =?iso-8859-1?Q?Pk+n9cxlxUHmIhZioReAPsgL2TxYo1tXLyf0zK1ZbJx9Okutm5qkQZNAZM?=
 =?iso-8859-1?Q?3Re02ZfsE5+YQ9By2OraSUX60pABdB7eae9VLDAJrsJTo72LZPuCHnB2uY?=
 =?iso-8859-1?Q?JOp9iKYjXnxE0PPlPWAQCY+i73Lu7ys4Y0C10C2+CjXo/Y3rVSJzLu0QQf?=
 =?iso-8859-1?Q?99CTfgt3+XJSLnQCHg9/EwQF3qiTBXl2lzJJsIrsHoNK/Dj0vPA75p59er?=
 =?iso-8859-1?Q?mKS6pdYqfOAToj+mcXuNkvolSthMkY36IGu5nlAaJ6emdB7SyTiCWF+wkF?=
 =?iso-8859-1?Q?aq4n6khj7A17ItD+EiIXNjf827eS8qw4OgB6SW7Ee27/iaLG+10wCaLFLi?=
 =?iso-8859-1?Q?3CBcIDz9uzRLFcNkbieMYyFydhKZgcJhIKIq0auudZxlyspaJyxxsIcQFQ?=
 =?iso-8859-1?Q?RmFJc4UgNCbouxc1bLsA3VZ/KxcxwUi0TgvF6NdrbgXZ/8qoiMjsSBKaE4?=
 =?iso-8859-1?Q?JSwPzO353AtF0XkahvnZxCBQ6sG02a988+Ez1RkGjIR1k5l4yLmuqjtBF3?=
 =?iso-8859-1?Q?2F8/Secd2B7LWJL1Uv1TNXf4Ee8KRDeuOAXGC7+y624aR+UX951jA8WOKs?=
 =?iso-8859-1?Q?HvfmtpzDGw3GnhbxSiIWjK/B7+7WhsIS7szO8BkaTORkv9a+2XMKL5gLML?=
 =?iso-8859-1?Q?ewosVdjiuixNHEpMiVBZgjSk7K5rQu5n6aU3SPxeWoOYtPFTpO/qQwo9dg?=
 =?iso-8859-1?Q?5D1dTkH2qA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hcdatainc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2456.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac63a3e3-1de8-45b9-93c3-08da4d870e55
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 21:52:48.2134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8368637-8933-4f2c-a6d2-c0d726d49c7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NrOE2qj6xq184xfQiYZna+G0Y67Xkb64QiWWAstBMkbIceMWCaRsU3yXOTQD7fTpfMQ+8e627n1HilOng5DyOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6019
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,=0A=
=0A=
We found a RoCE connectivity problem in such environment:=0A=
* two servers with ConnectX4 NICs (model: MCX414A-BCAT)=0A=
* servers are connected to one SX6036 switch where flow control is enabled=
=0A=
=0A=
Linux distributions, drivers and kernels:=0A=
* CentOS 7.4, CentOS 7.9 and Ubuntu 22.04=0A=
* OFED 4.9, 5.4, 5.6=0A=
* distribution default kernels: 3.10.693 for centos 7.4, 3.10.1160 for cent=
os 7.9, 5.15 for ubuntu 22.04=0A=
* vanilla kernels: 5.10 and 5.18 getting from Linux archive=0A=
=0A=
rping is used to test RoCE links connectivity between servers. At initial, =
they can establish RoCE connections (rping to each other works). However, a=
fter we did ifdown/ifup the interfaces, restart network services, or reboot=
ed the two servers, the connectivity between the two servers may become abn=
ormal: i.e. sometimes the active side was stuck at "rdma_connect" without a=
ny CM event generated later; sometimes, the connection can be established, =
but the sender side failed to send message to the receiver (with error 12: =
IBV_WC_RETRY_EXC_ERR). If we repeat ifdown/up the affected interface or res=
tart the network service for several rounds, the connectivity between the t=
wo servers can eventually become normal. We repeated this test on various l=
inux distributions, OFED drivers and kernel versions as listed above, and f=
ound that this problem can be reproduced on all these setups. TCP/IP connec=
tions are always working as expected. We are not sure whether it is a bug o=
r a configuration problem. Is there any method to troubleshoot this problem=
? Any suggestion is appreciated. =0A=
=0A=
Thanks,=0A=
Meng Wang=
