Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9535E7B4E88
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Oct 2023 11:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbjJBJDK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Oct 2023 05:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbjJBJDF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Oct 2023 05:03:05 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2073.outbound.protection.outlook.com [40.107.9.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CEEDA;
        Mon,  2 Oct 2023 02:03:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ix63YH6kl9LDCsA8kyCWM5IIPCBWvQQ/NObvRSbxee+pAsZ1yVHrhnzNg3eS0bUca7rYQP2E0x8CWwaARHxhkXAawtqW5Ne6ORACJ1udaeXW/1Uj+PbCxOhnJLjgeJ+0esX6euLDCAtvnVFjB/IQig0Xl5eoW/cCLrdPS1mc8u6HFlAhSMtfwvZvndaKzm3PcHEb4BgOCmZqJXjBUyQcvFJG+9xZ7C4gyUrCzKy1hoZP2c7BTzzZrSlPuqnjvyjBeUjg79eyG1vkoK6kVmGdPW/XxNW4dhYSEA9DGd0EpsXXNxqyWIQ+C6NAYa2wQsZuXzXVMHamJHF654eB3G8TAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tT5hiUKlaP3zn5htPJ5De6+jP9HZUKBL5XqW7313Naw=;
 b=WtNfUivDIjAF2SRQhPLgDc4PIUXPq9/ZE7lzeCYLCUxgZvt5zhtjhEaC21rVSC0dyhtWzl/p2su3nuDzs028JWGE3WH47xXJuxGHn4iRaEXYSVI5Zij/2TgxRlZjxW5T+wACZtyjigYbHNFoUyXfHObEuEqf9+iP8U3vHfijz+Lp3xe3IJ+x703Aryf/ai7x4We/LkL6gwGze2zgnJw8s7JLWn8IyTzUNUGb+9SUOzTGgOKabzTc3JqMFuzEivX+QASQrCykvCgvU1mL4FRxluSZ0xepCHwgEOxhOj79S2fXclWfm4UaAVakJFJP3Tj/LJ6C122DPh/Q1oqMlloIMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tT5hiUKlaP3zn5htPJ5De6+jP9HZUKBL5XqW7313Naw=;
 b=M7KdIW0I4gZYCwG5d1lEioTacEVbawmaO701wxEub4mP92kqkf7bj4ZPhk0E/7TZbj6LVvezI+UTjgIzZes4tOGqw8hi7ohDdRh2wugZPr0PWJYFMOFncZ6ux2bqzJciG4fk6zwjKZa9ITnKLT5RDrln6+BoBJOZPV1BaaC26tTsUMtC78ryNpMf6sZS/RkhsagHKACZFmIqpO3rleRKhKN32nOFBu1Ql3utRhFYY87LtMD4/efrTglWZWqRmmlzOA1x+ma1lwYT1mnSB2Ucr2Xeuq+Aa8E1i3TXzyTs1Nqrr54aAhAZxdvB/AmGGzyXqKFCuI0aHxDot9++JumMFg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB1613.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Mon, 2 Oct
 2023 09:02:58 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::27df:697c:bd7d:774f]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::27df:697c:bd7d:774f%6]) with mapi id 15.20.6838.024; Mon, 2 Oct 2023
 09:02:58 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Joel Granados <j.granados@samsung.com>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Corey Minyard <minyard@acm.org>, Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Robin Holt <robinmholt@gmail.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Russ Weight <russell.h.weight@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Song Liu <song@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 00/15] sysctl: Remove sentinel elements from drivers
Thread-Topic: [PATCH 00/15] sysctl: Remove sentinel elements from drivers
Thread-Index: AQHZ8g7L9GtM3GaC7kiSbpIXyc5PdrAwblgAgAXHowCAAARdgA==
Date:   Mon, 2 Oct 2023 09:02:58 +0000
Message-ID: <e9966cb5-40dd-6a53-dc22-4a1fd1f8a2e2@csgroup.eu>
References: <20230928-jag-sysctl_remove_empty_elem_drivers-v1-0-e59120fca9f9@samsung.com>
 <CGME20230928163139eucas1p261a3b6b6cc62bafd5ace2771926911c2@eucas1p2.samsung.com>
 <5fadd85e-f2d7-878c-b709-3523e89dd93a@csgroup.eu>
 <20231002084718.bmme7yi4xfs7sw4b@localhost>
In-Reply-To: <20231002084718.bmme7yi4xfs7sw4b@localhost>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB1613:EE_
x-ms-office365-filtering-correlation-id: adfe874a-b6fb-4bb7-ae0f-08dbc3265fb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: huib1xu4cRxSeJbUhGWDFR4PK9/qZji4WeLJtNogtv9lSbuf6HtlZqV/cIYJM6Dmq9Xc1vyj7FsjZ8JG2ejJDnhR95Kd0FgbGUHvf1hBPgs97LFIc2Id2lYbU2yxHX7B3c4rggYG+C8Umz32FPx10ZZtfdprp89ltz+8JcTH+a3iTixYeIPQqoTerzWrrdco8H9SYIenXjAwxto2DBMkYiLo9gzAVmhmHwEa6FSWP7m6mNDmAkOK/1pXPjJ+mRUizwovh40Thc0QtRiKELqjVAO2qO9Refu5xV7W+eCPtwbXLY0rQjXDKHvE2P9gcG6dFteWKDMqZR//x7ABI1X6dAig8BzIa5A8uL7WD8MgbO5m0liYUz6ZeCDcqHhk7DaLJNiWjVjkGlFALcF7QgLixex2+46SglwaMrkaWpwBG6U8c0HLBYkiGzcoRIipHThLzW2Lwu+t2k9FGPNEirAIydNdWDeI8MU3HW0mKYtsq3bZii7tQEgkmV6GtmqlqGO8iecoQ4mTgCW90AYJe63dCHZoJywXq5Pi0UQ3I+N4EP31y/a7/+YD1wVcucLHhg7Gvt4EiBR/Oi+5udBZEc8q128QztBo/nuIitN1DkQalKWkCc3e2iGx1mx7L5GwP/p9wlfZEmyWE8RK7GVZyHmfQvKTDlHLbGCSgyy9HN5s6L8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39850400004)(396003)(346002)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(31686004)(2906002)(316002)(41300700001)(54906003)(4326008)(8676002)(8936002)(4744005)(7416002)(7406005)(7366002)(44832011)(36756003)(91956017)(5660300002)(76116006)(6916009)(66556008)(66446008)(66946007)(31696002)(478600001)(86362001)(6506007)(71200400001)(6512007)(38100700002)(2616005)(38070700005)(122000001)(26005)(64756008)(966005)(66476007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUFkVkpuM3NUdSt5Qk84cEhSVGNvT3FGQmFOZWRuN3pTeVhRa3JHMWFwNTdJ?=
 =?utf-8?B?WG1zdmJLSWdDb3hVWjcwOE1WY3pFVTdmbUpodXpseGhBU3ZxSUcwR0RiMHJr?=
 =?utf-8?B?aFREbThEVGpjMWZFRSt0TDYxOHVNSU1sT3ZjWHhxVTJoSVQzN1psaml0V0RJ?=
 =?utf-8?B?QnJMaHNMdEZHZmhVOEhFaDNUaDdqbG95WHhPMk95clZiREJwNXVkZW9kbE9V?=
 =?utf-8?B?ckExTHYwcVJhM2ZCVStUMEhub0ZnMlBOT0JuVE9jVE9KWnlFYmNqTmhrL1lX?=
 =?utf-8?B?d09mYkdVTVAzRGxreUNMVjJYTkd2MlNUdm9sQitEUjFXRGFmcGpmZEJYWGF2?=
 =?utf-8?B?R1JPSFFteHJ0MHJFT01NeS9XL1RZeURKSk52U25uUEt2a0lXbTllU1BNSVd3?=
 =?utf-8?B?R2lMaXZrV3pQRzlHNHRFYzgwbFRiWWNjWlBFNEF5UUZWOEJSVTZ0RDl3enVk?=
 =?utf-8?B?NE5naWdXWjB2Vm1QK1dUWGwzVzYwTUxrWXFLd00vYnBka2xMWDJ6b3FZSXJI?=
 =?utf-8?B?RWVsbVIxK290ZWYrUW1yQXB5VFc1bTZ0L1d3T1BqV000Z0MzdHN1dHdQa2hH?=
 =?utf-8?B?N2M1eXlxZjlMekZubXJ3dmVDUGUyNzZnM1o4eHA1OE5tSk5uL0dxMldtKzdM?=
 =?utf-8?B?S3A0bEFTZ2lXM1BYK1h3bUNyMldqbjFnS3NaM280RThJZnlOTnRSVko3OHgx?=
 =?utf-8?B?NzVTTU8zS0JuSkdqc0ZuSVBiQ1dQaGd2TEpZWG42M3pkODgyZWFsQjFOS1NF?=
 =?utf-8?B?MHpKSzZnZlNvTWF4MzFZU0d0b3VOT0hVR0lhK1pKYXJ0Rkd5UktnYUQrUVJZ?=
 =?utf-8?B?TE01Umd6em9lb3l5anFWSHZSelliNFpsQjRyNW5zcEtVdGNsQWROcGpnVFR0?=
 =?utf-8?B?ZExaQ0xxQXFsWnJQS3RVMENDeWdYMkF5b1hyRVRxVHMyeGgvNUpNMW01endp?=
 =?utf-8?B?VmJWZ3NWRE1venROeU95eS9ncGx3S2c4amhJMnJ6MUFNa1FrT1NxRENJMTBm?=
 =?utf-8?B?MFY5emNoeWFhYlVGUzNyMDBEaElKRml0OEE0M2VwOWxRbmlxUFZEQ0xFMktU?=
 =?utf-8?B?RExUdWpmd2d5UUdBODBQVDRwaUdiTElpdTNDVGU3dkpxYk5KR0ZZNFdjRHU2?=
 =?utf-8?B?WW92Ums0RFUydnlvdldvanNodXZJUS9tZnUrSlhIWFVFVTE1V2EzckhWQVNL?=
 =?utf-8?B?L0t1bHlGYVk4SHYycVB3V2ZNMDhHZUxTbzZrd1JmZVQ0ZC9UTjhEeURyQ2Er?=
 =?utf-8?B?MElGRXdSL1k3S1hWVW54RVh1bHlaOUI1MXZaQXl5WFNPTWk3TWwwYjhzUlQy?=
 =?utf-8?B?Q2hBTGthOEF0d2xNNXBLVjZxaFlsKzRXdmVRaVNDY2ZzcmtqYUk2Qmp2b09y?=
 =?utf-8?B?aEZ2cHh0TGFaZ1J3QkV1Q2U1Y0xtcDFpKzVxQm05T2tCWmVrSXkxYkVBM3BR?=
 =?utf-8?B?LzRLTUpKcEJKQm9rMGU1U1d2RFpueWZEZkx4ZDU3L2dOTWd4cStBZCtZNjhC?=
 =?utf-8?B?YXlCK2J3YU9DaFlQL2tKckMvVjVQR0xnbmdjYkpLaDRXak8yVFczQXljUzVC?=
 =?utf-8?B?MjJsY3pheUtGK2xuTjZha1BJcGhNZlV6S040dSs2aGsrMkIwSXljZE84MkpC?=
 =?utf-8?B?L2lmeVc3c3BMVm53VWFDeXBleWE0aGJ6OWxGanZ3RkxDajgxN2RkYnlXY3ht?=
 =?utf-8?B?NkRyOUg4UkpjRmdrQlVOMlpMNUt4OWk2MHJMd0ozUit5K1p4U0Nmaml4Z29z?=
 =?utf-8?B?OTg3NVpHaVZ6emJMdlRzNWIySjVsa0tyZzBNUzhOdXhQcmJLUGJ0ZjNpeFFi?=
 =?utf-8?B?blR6ZXlidUNKLzFpTGJ4UjlFTnNBZXprRDNsVi9Bck9ZMHIvaUNXNldGZlFG?=
 =?utf-8?B?Q3oxOEFZWmxxVEhBVnlVVmtPbm5XWmJqTjFYcFY3bFNOc2tSUzhpZjB6N0o5?=
 =?utf-8?B?ZFh4d2l2RFJqSVBLYVpvVTRaZHRjZHdpeGtKcEtVMlUxQU14QlhZRzMwTitp?=
 =?utf-8?B?d2RpQmdzMFViRE9GaTl6K09BcjlkUUdsNjJPdjNHQnBMOVpobklELzFPeGIw?=
 =?utf-8?B?TVlabEg0bFVtb1dZSkl2OC8wbkZaTGpqQVd4RXNoSjk2QUxveEZJSlRaTE1K?=
 =?utf-8?Q?LEsZii/Ui0/fDYRyDQ4Umczsz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B19610D21F9A0E40914B707EAD7D9548@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: adfe874a-b6fb-4bb7-ae0f-08dbc3265fb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 09:02:58.4694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NxPxZfZhpijteIMxVFAWbceSw5KI2eWhoFxz+uH4uLMXCZsIZsxfc038Mh5FhXTNxIsSgItv/DkNOE1ITly8Mf3LyYxtnGop2N1fxfK/P3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1613
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCkxlIDAyLzEwLzIwMjMgw6AgMTA6NDcsIEpvZWwgR3JhbmFkb3MgYSDDqWNyaXTCoDoNCj4g
T24gVGh1LCBTZXAgMjgsIDIwMjMgYXQgMDQ6MzE6MzBQTSArMDAwMCwgQ2hyaXN0b3BoZSBMZXJv
eSB3cm90ZToNCg0KPiBJIGZvbGxvd2VkIHRoaXMgdHJhY2UgYW5kIHByb2NfaGFuZGxlciBpcyBj
b3JyZWN0bHkgZGVmaW5lZCBpbiB0dHlfdGFibGUNCj4gKHN0cnVjdCBjdGxfdGFibGUpIGluIGRy
aXZlcnMvdHR5L3R0eV9pby5jOnR0eV9pbml0IGFuZCB0aGVyZSBpcyBub3QNCj4gcGF0aCB0aGF0
IGNoYW5nZXMgdGhlc2UgdmFsdWVzLg0KPiBBZGRpdGlvbmFsbHksIHdlIHRoZW4gZmFpbCB0cnlp
bmcgdG8gcHJpbnQgaW5zdGVhZCBvZiBjb250aW51aW5nIHdpdGgNCj4gdGhlIGluaXRpYWxpemF0
aW9uLiBNeSBjb25qZWN0dXJlIGlzIHRoYXQgdGhpcyBtaWdodCBiZSBkdWUgdG8gc29tZXRoaW5n
DQo+IGRpZmZlcmVudCB0aGFuIHRodCBzeXNjdGwgcmVnaXN0ZXIgY2FsbC4NCj4gDQo+IERvZXMg
dGhpcyBoYXBwZW4gY29uc2lzdGVubHkgb3IgaXMgdGhpcyBqdXN0IGEgb25lIG9mZiBpc3N1ZT8N
Cg0KRG9uJ3Qga25vdy4NCg0KPiANCj4gVG8gd2hhdCBicmFuY2ggYXJlIHRoZXNlIHBhdGNoZXMg
YmVpbmcgYXBwbGllZCB0bz8NCg0KQXMgZmFyIGFzIEkgdW5kZXJzdGFuZCBmcm9tIA0KaHR0cHM6
Ly9naXRodWIuY29tL2xpbnV4cHBjL2xpbnV4LXNub3dwYXRjaC9jb21taXRzL3Nub3dwYXRjaC8z
NzUzMTksIA0KaXQncyBiZWluZyBhcHBsaWVkIG9uIA0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvcG93ZXJwYy9saW51eC5naXQvY29tbWl0Lz9pZD1kNzc0
OTc1DQoNCg0KPiANCj4gSSdtIGdvaW5nIHRvIHBvc3QgbXkgVjIgYW5kIGtlZXAgd29ya2luZyBv
biB0aGlzIGlzc3VlIGlmIGl0IHBvcHMgdXANCj4gYWdhaW4uDQo+IA0KDQpDaHJpc3RvcGhlDQo=
