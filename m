Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8913C4F8C6A
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 05:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbiDHDRE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Apr 2022 23:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbiDHDRD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Apr 2022 23:17:03 -0400
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31C8186F91
        for <linux-rdma@vger.kernel.org>; Thu,  7 Apr 2022 20:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1649387701; x=1680923701;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DpckrmzIOZlw57aGJRT3bVNWNlVuUt2dI7oAGCRWEU0=;
  b=iEjFo6viJbiubhMkv1I3NQz7Ijw/pVPgAAOKIBWqNYecnd9Ula8P8tGS
   JOcMi6ypLl1czspCqGI6YzH9gDpJqe6L/hcqOphxrf90rCCEAIxD16aIw
   axW1w5US0SaWWb4xMXtrLs9cDKUaktJvB6kWE3BV8/xJHDq0bR/Je0EYe
   BuGI+5qOArGjzj6cvnbG0eVWj65biBh/xUG1w0O3kqr9yeM95Me+dO6cD
   +gtgIqjihC/29E9+8+WwEbOea818F5m7b1VUdAIR6bp83aXgMYRiHgNBZ
   SGQ1h+r8LSv8ot/xuYFl5G/mm939JK7QLeejSArXATpeKJTz73cRo5un9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="53464259"
X-IronPort-AV: E=Sophos;i="5.90,243,1643641200"; 
   d="scan'208";a="53464259"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:14:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0QqPXSYAznrTuf+Vg++O6FRoudayEnZdSKrKBmgqvQHLDUijK9covJcYkXe1uGhOo2ukveAARi3GbV6GgVXbRjOO3os9JMMXxVH/U7LZC+OjZAqbE1Wm3+m9jAP0za64TSVbEm4gldy/bkAiXpNX2nMwC30jRZcrQlck6IRfyvr+WQq3QU9xEwEtg51Q8/9VeUc7y4mXIg6+Bf1PGBXz+jEQRxqyUL3ROKLV4qPSGIeb/c5qNlAeuYdWPq22cAu/gP/KhaY3HxsvHn6jkZuegWfSv6mHHAK2F7IMgksEoBjbJ5diYIbCIW9pg1bvo6e6sIG347y8zvPUsP67ZxEPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpckrmzIOZlw57aGJRT3bVNWNlVuUt2dI7oAGCRWEU0=;
 b=SVBdfmJqfzvAe4U/xcrge4uDGu1/Mkw67soJO7jS+aD9m+XjfWeIRlWnmp18mL9Prlqfa6RSXMAmtxTrbz8UkPXRdFt2T4zJ47MiK7teLxjrYL3wQHv+kG5XcR8inMsuy4JYxI19d7/qew8WP4WDBkNfKU9hw73vF9bKHZJQEsX2MZyexO/7U8twBC+FcM+4bEX41YVyy3IX+BHvu34QOq2bsejGfbit65lyMlmnTyFkwRb3tdM59OM1I0spW3pPEgrw8UgaQ2GSGJQFtgfTKXLoKodfupgDXOa7QoQmb2XqgANKs4Z/sPAkNbdd0HLJwBpt8K4beGHVXUBeStCt8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpckrmzIOZlw57aGJRT3bVNWNlVuUt2dI7oAGCRWEU0=;
 b=PsfMyiux716l7J1xr0y3N9mqhf6k5seWedyvKENYhuVwhExuY3Mgj19YfOuwu7RyWoj1Fjsk4FS5IrnBpoYR3cQ7Jwo9m9/CMo1pF9RrlZHEh8zH3h/A+Wkp+Npp7qAfxVlE77I9tsCZqgajFR+TaIH+CrtZJVjHZY5Mb28gE8w=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by TYWPR01MB8559.jpnprd01.prod.outlook.com (2603:1096:400:170::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 03:14:54 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::81d3:f9c:79b0:edf5]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::81d3:f9c:79b0:edf5%4]) with mapi id 15.20.5144.021; Fri, 8 Apr 2022
 03:14:53 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3] RDMA/rxe: Generate a completion on error after getting
 a wqe
Thread-Topic: [PATCH v3] RDMA/rxe: Generate a completion on error after
 getting a wqe
Thread-Index: AQHYRPdCYpfAZyHhJke4+LIBKDHWV6zlBfiAgABdtwA=
Date:   Fri, 8 Apr 2022 03:14:53 +0000
Message-ID: <81115ff0-a076-7292-8dad-49c9d5666b87@fujitsu.com>
References: <20220331120245.314614-1-yangx.jy@fujitsu.com>
 <5c806f62-d258-7860-4b6b-416adc603879@gmail.com>
In-Reply-To: <5c806f62-d258-7860-4b6b-416adc603879@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99a56bcf-c242-4baf-5447-08da190df356
x-ms-traffictypediagnostic: TYWPR01MB8559:EE_
x-microsoft-antispam-prvs: <TYWPR01MB85596EE947FD927F5F51B02383E99@TYWPR01MB8559.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cDMNbjAzZEJ2I2xjmUHH/NEGGNuPcf+WkC1OalvWCHSpdTuJH+U7EfH5xl6Z9mAZAAL6/hObl3ERqFBx4ga5WyN6ko1wMCGcuIXwsyQZqb3d5ir5IeR+9trMq9Yvv3GhsQeI/IVCRhB+Kqx7sILbSuXq96jguCi44tw40KC6r1U3AGRoSU9Ya1DsejTmwTYeENHC0uJ/NY30fgC+NtXFwOTsloC8MCkAEuckaUm5Hbn+XyynF1R1iGge3ZqJtS+jX4ayMSSfDV8ZxFLD/6S7K/M7iOiXaCx5q/0SlCbHUKsym1ypybVJj/y107FVyRoIAimCyjthm+ETGJqV/7HnRqEEQuVWbTsbHq1V+jROamlwOmTWMykO7HHRBdD6OuYA+cY4z7+IvvqE9m0aHGhbSBkXtjBnEpyPvoB7ymtJFUEs9y+oszAVY1M+M5MSmT8zGc198DwQiNt5J6cu++ZM31z9+Mzl+SILOfL2bM/NSkB/HO8lm9x9aKBIpIzv+EQlXwTG0ZPOWxVGAT/9t0uUMcNL3F1aW7tbNV5xLNRKPCoVWyKlmsW+e3zJqgA2k/eA1igt6/kqXQpPisYqXkzmM//HL0EUt5+eFld+nBqRzewLZKFsznFvrue5fePWpjpmF3w5wLpBccyTn9yIBaRWuU8yqQQ1D/v8dRTTxnAt5M3Ek+e9g4TUJhQec+q2mgsrR4Hx5gHMBmLJmbD5tZ1TtwiqcCZQMML/JQG0ddziW0M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6512007)(122000001)(110136005)(82960400001)(6486002)(316002)(83380400001)(71200400001)(36756003)(31696002)(38070700005)(66556008)(66446008)(2616005)(66946007)(26005)(4326008)(66476007)(8676002)(186003)(76116006)(91956017)(64756008)(508600001)(53546011)(38100700002)(85182001)(6506007)(31686004)(8936002)(2906002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eE4xcDFsU2wzYmF4cVFqZkZPc2ZzRWk5c3BZNFl4dVpqaDV1ditueTFJVWY5?=
 =?utf-8?B?UXRzU1dSUThEYnJjVnd1MWtLWEZtbXJQQmFiYlVvQTNpZTJkQVFCbGMzNy9i?=
 =?utf-8?B?MzlYeVp3V0grT1o4ak0rKzlOSWlJVWJ5TGFQanFCbmZWVWNFMTF0YmNoSjVm?=
 =?utf-8?B?RTdML2M1TDRlUnNZemNGOVhpV2I2MkZPc2JIVy9YalJraE5MekZYTGduR09Y?=
 =?utf-8?B?Wi9MWG4xSENZWEtEd0ppUlJZR1JOUml1ODhrMHc2bmVwZzVUQzBtMk1PeW8w?=
 =?utf-8?B?QWdhTEpxMGlzdVR3TWFKVHp4Zzk2SGpLR0t4Q2MrVk1OOEQwaWNIU1JodXZK?=
 =?utf-8?B?NW1RRGxFUmdEZm9iaE8wU011Q0taSFpRQlhtbVp6RU1HUnNTclM4U3k5TUJv?=
 =?utf-8?B?QVc2STNTL2pULy9GQlFSL3lOSHZMK2VyV3ZYYUx6cHpHRTVjampjZkxTaVFr?=
 =?utf-8?B?bXdnOTY4T21TdUNQTW13MlphNlRGbEpUWnp4NmFNaEUxZ1pVelBobU9Bdlp3?=
 =?utf-8?B?RFFXMWxpRFMxZHptU0NPQVQ3SlRzQW43dXlJbzM1U3ZOMXpOb2lyU0UyaThV?=
 =?utf-8?B?d28rNFlSQi8xRk5wYi9panlsYTVKYnJDNXkrcVd6Q3p2S1hXdUMzcFlLeU9X?=
 =?utf-8?B?aTcwNkloaThNV2ZSRG5jRXB1NEFuMVBvdE1tZTRjVitTNXczditCbDE5SlRp?=
 =?utf-8?B?Uzg4Nkc0RW8waGQ0cURPRzJwWlhMUFNGOWcwVzB1SENNVlhZdEtDa2FzMXRo?=
 =?utf-8?B?VWdKbS90R3B5V3FoamR3VUlwL3g0M1lqNUk1L05EUVg2WDlkZng3OVE4ZTlW?=
 =?utf-8?B?UUtRZkpraTBrTk5QdzJMaW9KTGMzOW5NNnh1ZnFycUNWMHJLU1h2bTZzNytJ?=
 =?utf-8?B?WDJ1NmdpMzc4cVlMVUd3RXBBRVl1R0J3ZWtuL0JrazVsa2ZHclA3b1I5STJX?=
 =?utf-8?B?MTFlNlVyVUtkZ2hsaFVsWHNZZXlwRUV5LzV3c2x1YWp1Y1l3VUJPOU1FOE1P?=
 =?utf-8?B?bDlKWHR4cTBndll5MGU0ZDZ4NFRZTWhVL0NkRm14UFN4WFNYZGFtQklLUHRu?=
 =?utf-8?B?YUU4a3h3Q3FkWTNCQUw0NHZxZ2JSRk1Rdk5wM0IyL0wzZU5uUjBJTXBsNVNM?=
 =?utf-8?B?TkxuVEJ2KzNGeC9tUmNCV0Z1Q2xLaGVwY3lWaEp0ZE4xNEhBTllEa0I0bGFm?=
 =?utf-8?B?Si9EbHdSOHRlYzlWcy9saUN1OE5DdHdSYThoaUFpcTZXOVZlTnIzL3NKRU9B?=
 =?utf-8?B?SHRPZzdwUVkybjNXOUE2Q0FWaTI1UzVXbU9FRUJNL2tKcnFQb2ZiSzFnd1JC?=
 =?utf-8?B?ZUhDNHdTM1IvMHl3VW9rbGV1S2Qrb1JqMVZMOUtzbUdOS0tkazJuODhURlFa?=
 =?utf-8?B?TFRPK0hzcGhRanlMelJOUi9hSnpCQ1UzODNWb0k2MHN5VjdtUGVyQWVTc0Z3?=
 =?utf-8?B?dnRhVEw1dnNjSjljL01sd2NHRDZPY2cwMU9sbW1TcFhxeVhaUVRISlJJUVVB?=
 =?utf-8?B?RGdVT3JSSDJ0RmplcVUzV2MwbGIwb2I3WFJQdXE4OWVESzUzVjlpS296bDhz?=
 =?utf-8?B?c1E2OGVMR3pjS0xkMUtvWTA2Z0EvcTJnem0zNnRKYjdSZEovdnVKcTl4aFlK?=
 =?utf-8?B?TnNIL3lNYjVLK1puTVV5bVA1ZmtqcHhvemJQcnROK3RjdUtHRHcrNE0xK21L?=
 =?utf-8?B?NWJGRGt5MXpDNW1Rc21Fb3l5ZmJEOCtSTmRuRW1GaUVmYyt6Ui9rQ1BXWEJj?=
 =?utf-8?B?c09XeVd0MFJ4VWEvdHhVQjVJVnRaYTEraXBjajBUUU5sQ1FXMW1qOG11YXor?=
 =?utf-8?B?UCtWMHdmeFZKMlRTc1ZIKzd1SUsvYWc5UEV0anNzeko0enY0VmVtZW1IYjNk?=
 =?utf-8?B?OGc4T0JOcWtpQnRIQ1dBYmFLUkwwQ2xMVXdsRnZoOFlSaXVTRGQzVEFRWmYv?=
 =?utf-8?B?ZVNBZUk4WlNPZWJYNWlYSjM0bzQ2b2pvOUZvaGZqUTNLaFBKaWs1NVIyeGQv?=
 =?utf-8?B?QmJzdzdLMHcwcjBtTVQ4WUxWZUpRanM0ZlREemliYnFNLzMxK2Z0VXpYRVpF?=
 =?utf-8?B?T2pJQzdCSkQvNTlmZ1k4ZHl2endqQnU4ZEdWa0I1cUREanhDY1R0NjQ4RU9T?=
 =?utf-8?B?MTJaREZRS0xmTkZjY3BtTURnOElXRXVTSFB4SnFHYjV0RHlxQUhwSTZDL0Ew?=
 =?utf-8?B?RWxYQ204R2pZNk5oK0Rvd29mQ0dzMm5PSTZ5NU1qUENLNHFOdlRhc3d0Wjhj?=
 =?utf-8?B?ZTk2YVpIaXQwc1lSbkVRN2xhRjFjdTRUa1l4VGdiM0dXNXpkNUVRMXlMKzds?=
 =?utf-8?B?M1liWmcrWWZkUDlLOG5NWGVmWTMvYTBBNENFVHlyMmdhVjM1UkJTUmRmaDRa?=
 =?utf-8?Q?vsv6/z5+6lsHDAi8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7628CA5C49A92C4BAE17513C72921BD8@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a56bcf-c242-4baf-5447-08da190df356
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 03:14:53.1949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8fq2TZyQebUolS7wzeDq1kwk0zB8B4GJPNy/DGbDre7wY4UTP31K0pJa4tisdvLcOKb4cr9+b3hLNeUIRaacSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8559
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGkgQm9iLA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgZGV0YWlsZWQgY29tbWVudHMuDQoNCk9u
IDIwMjIvNC84IDU6MzksIEJvYiBQZWFyc29uIHdyb3RlOg0KPiBPbiAzLzMxLzIyIDA3OjAyLCBY
aWFvIFlhbmcgd3JvdGU6DQo+PiBDdXJyZW50IHJ4ZV9yZXF1ZXN0ZXIoKSBkb2Vzbid0IGdlbmVy
YXRlIGEgY29tcGxldGlvbiBvbiBlcnJvciBhZnRlcg0KPj4gZ2V0dGluZyBhIHdxZS4gRml4IHRo
ZSBpc3N1ZSBieSBjYWxsaW5nIHJ4ZV9jb21wbGV0ZXIoKSBvbiBlcnJvci4NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBYaWFvIFlhbmcgPHlhbmd4Lmp5QGZ1aml0c3UuY29tPg0KPj4gLS0tDQo+PiAg
IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jIHwgMjQgKysrKysrKysrKysrLS0t
LS0tLS0tLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxMiBkZWxl
dGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGVfcmVxLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXEuYw0KPj4gaW5kZXgg
YWU1ZmJjNzlkZDVjLi4wMWFlNDAwZTU0ODEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2luZmlu
aWJhbmQvc3cvcnhlL3J4ZV9yZXEuYw0KPj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4
ZS9yeGVfcmVxLmMNCj4+IEBAIC02NDgsMjYgKzY0OCwyNCBAQCBpbnQgcnhlX3JlcXVlc3Rlcih2
b2lkICphcmcpDQo+PiAgIAkJcHNuX2NvbXBhcmUocXAtPnJlcS5wc24sIChxcC0+Y29tcC5wc24g
Kw0KPj4gICAJCQkJUlhFX01BWF9VTkFDS0VEX1BTTlMpKSA+IDApKSB7DQo+PiAgIAkJcXAtPnJl
cS53YWl0X3BzbiA9IDE7DQo+PiAtCQlnb3RvIGV4aXQ7DQo+PiArCQlnb3RvIHFwX29wX2VycjsN
Cj4+ICAgCX0NCj4gVGhpcyBpc24ndCBhbiBlcnJvci4gV2hhdCBpcyBoYXBwZW5pbmcgaXMgdGhl
IHJlcXVlc3RlciBoYXMgYWR2YW5jZWQgdG9vIGZhciBpbnRvIHRoZQ0KPiB3b3JrIHJlcXVlc3Qg
cXVldWUgY29tcGFyZWQgdG8gd2hhdCBoYXMgYmVlbiBjb21wbGV0ZWQuIFNvIGl0IHNldHMgYSBm
bGFnIGFuZCBleGl0cyB0aGUNCj4gbG9vcC4gV2hlbiB0aGUgY29tcGxldGVyIGZpbmlzaGVzIGFu
b3RoZXIgY29tcGxldGlvbiBpdCB3aWxsIHJlc2NoZWR1bGUgdGhlIHJlcXVlc3Rlci4NCj4gUlhF
X01BWF9VTkFDS0VEX1BTTlMgaXMgMTI4IHNvIG9ubHkgMTI4IHBhY2tldHMgYXJlIGFsbG93ZWQg
aW4gdGhlIG5ldHdvcmsgd2l0aG91dA0KPiBzZWVpbmcgYW4gYWNrLg0KDQpHb3QgaXQuDQoNCj4+
ICAgDQo+PiAgIAkvKiBMaW1pdCB0aGUgbnVtYmVyIG9mIGluZmxpZ2h0IFNLQnMgcGVyIFFQICov
DQo+PiAgIAlpZiAodW5saWtlbHkoYXRvbWljX3JlYWQoJnFwLT5za2Jfb3V0KSA+DQo+PiAgIAkJ
ICAgICBSWEVfSU5GTElHSFRfU0tCU19QRVJfUVBfSElHSCkpIHsNCj4+ICAgCQlxcC0+bmVlZF9y
ZXFfc2tiID0gMTsNCj4+IC0JCWdvdG8gZXhpdDsNCj4+ICsJCWdvdG8gcXBfb3BfZXJyOw0KPj4g
ICAJfQ0KPiBUaGlzIGFsc28gaXMgbm90IGFuIGVycm9yLiBIZXJlIHRoZXJlIGlzIGEgbGltaXQg
b24gdGhlIG51bWJlciBTS0JzIGluIGZsaWdodC4NCj4gVGhlIFNLQnMgYXJlIGNvbnN1bWVkIGJ5
IHRoZSBldGhlcm5ldCBkcml2ZXIgd2hlbiB0aGUgcGFja2V0IGlzIHB1dCBvbiB0aGUgd2lyZS4N
Cj4gVGhpcyBwcmV2ZW50cyB0aGUgZHJpdmVyIGZyb20gdXNpbmcgdG9vIG11Y2ggbWVtb3J5IHdo
ZW4gdGhlIE5JQyBpcyBwYXVzZWQuDQoNCkdvdCBpdC4NCg0KPj4gICANCj4+ICAgCW9wY29kZSA9
IG5leHRfb3Bjb2RlKHFwLCB3cWUsIHdxZS0+d3Iub3Bjb2RlKTsNCj4+IC0JaWYgKHVubGlrZWx5
KG9wY29kZSA8IDApKSB7DQo+PiAtCQl3cWUtPnN0YXR1cyA9IElCX1dDX0xPQ19RUF9PUF9FUlI7
DQo+PiAtCQlnb3RvIGV4aXQ7DQo+PiAtCX0NCj4gVGhpcyByZWFsbHkgaXMgYW4gZXJyb3IsIGJ1
dCBvbmUgdGhhdCBzaG91bGRuJ3QgaGFwcGVuIHVuZGVyIG5vcm1hbA0KPiBjaXJjdW1zdGFuY2Vz
IHNpbmNlIGl0IGltcGxpZXMgYW4gaWxsZWdhbCBvcGVyYXRpb24uIExpa2UgYXR0ZW1wdGluZw0K
PiBhIHdyaXRlIG9uIGEgVUQgUVAuIE9yIGNhdXNpbmcgYW4gaW52YWxpZCBvcGNvZGUgc2VxdWVu
Y2UuDQoNClllcywgdGhpcyBpcyB0aGUgaXNzdWUgSSB0cnkgdG8gcmVzb2x2ZS4gQ3VycmVudCBy
eGVfcmVxdWVzdGVyKCkgZG9lc24ndCANCmdlbmVyYXRlIGEgY29tcGxldGlvbiB3aGVuIHByb2Nl
c3NpbmcgYW4gdW5zdXBwb3J0ZWQvaW52YWxpZCBvcGNvZGUuDQpJIGFtIHRyeWluZyB0byBpbnRy
b2R1Y2UgbmV3IFJETUEgQXRvbWljIFdyaXRlIG9wY29kZSByZWNlbnRseS4gSWYgcnhlIA0KZHJp
dmVyIGRvZXNuJ3Qgc3VwcG9ydCBhIG5ldyBvcGNvZGUgKGUuZy4gUkRNQSBBdG9taWMgV3JpdGUp
IGFuZCBSRE1BIA0KbGlicmFyeSBzdXBwb3J0cyBpdCwgYW4gYXBwbGljYXRpb24gdXNpbmcgdGhl
IG5ldyBvcGNvZGUgY2FuIHJlcHJvZHVjZSANCnRoZSBpc3N1ZS4NCg0KPj4gKwlpZiAodW5saWtl
bHkob3Bjb2RlIDwgMCkpDQo+PiArCQlnb3RvIHFwX29wX2VycjsNCj4+ICAgDQo+PiAgIAltYXNr
ID0gcnhlX29wY29kZVtvcGNvZGVdLm1hc2s7DQo+PiAgIAlpZiAodW5saWtlbHkobWFzayAmIFJY
RV9SRUFEX09SX0FUT01JQ19NQVNLKSkgew0KPj4gICAJCWlmIChjaGVja19pbml0X2RlcHRoKHFw
LCB3cWUpKQ0KPj4gLQkJCWdvdG8gZXhpdDsNCj4+ICsJCQlnb3RvIHFwX29wX2VycjsNCj4+ICAg
CX0NCj4gVGhpcyBpc24ndCBhbiBlcnJvci4gSXQgbWVhbnMgdGhhdCBzb21lb25lIHBvc3RlZCBh
IHJlYWQvYXRvbWljIG9wZXJhdGlvbg0KPiBhbmQgdGhlcmUgYXJlIHRvbyBtYW55IHBlbmRpbmcg
cmVhZC9hdG9taWMgb3BlcmF0aW9ucyBwZW5kaW5nLiBZb3UganVzdCBuZWVkDQo+IHRvIHdhaXQg
Zm9yIG9uZSBvZiB0aGVtIHRvIGNvbXBsZXRlIHNvIGl0IGlzIGFub3RoZXIgcGF1c2UuDQoNCkdv
dCBpdC4NCg0KPj4gICANCj4+ICAgCW10dSA9IGdldF9tdHUocXApOw0KPj4gQEAgLTcwNiwyNiAr
NzA0LDI2IEBAIGludCByeGVfcmVxdWVzdGVyKHZvaWQgKmFyZykNCj4+ICAgCWF2ID0gcnhlX2dl
dF9hdigmcGt0LCAmYWgpOw0KPj4gICAJaWYgKHVubGlrZWx5KCFhdikpIHsNCj4+ICAgCQlwcl9l
cnIoInFwIyVkIEZhaWxlZCBubyBhZGRyZXNzIHZlY3RvclxuIiwgcXBfbnVtKHFwKSk7DQo+PiAt
CQl3cWUtPnN0YXR1cyA9IElCX1dDX0xPQ19RUF9PUF9FUlI7DQo+PiAgIAkJZ290byBlcnJfZHJv
cF9haDsNCj4+ICAgCX0NCj4gVGhpcyBpcyBhbiBlcnJvci4gSXQgY291bGQgaGFwcGVuIGlmIHRo
ZSBhZGRyZXNzIGhhbmRsZSByZWZlcnJlZCB0byBieQ0KPiB0aGUgV1IgaXMgbm90IGxvbmdlciB2
YWxpZC4gVGhlcmUgc2hvdWxkIGFsd2F5cyBiZSBhbiBhZGRyZXNzIHZlY3RvciBidXQNCj4gdGhl
cmUgbWF5IG9yIG1heSBub3QgYmUgYW4gYWRkcmVzcyBoYW5kbGUgaWYgdGhlIEFWIGNvbWVzIGZy
b20gYSBjb25uZWN0ZWQNCj4gUVAgb3Igbm90Lg0KDQpZZXMsIEkgdGhpbmsgdGhlIG9yaWdpbmFs
IGxvZ2ljIGlzIGVub3VnaC4NCg0KPj4gICANCj4+ICAgCXNrYiA9IGluaXRfcmVxX3BhY2tldChx
cCwgYXYsIHdxZSwgb3Bjb2RlLCBwYXlsb2FkLCAmcGt0KTsNCj4+ICAgCWlmICh1bmxpa2VseSgh
c2tiKSkgew0KPj4gICAJCXByX2VycigicXAjJWQgRmFpbGVkIGFsbG9jYXRpbmcgc2tiXG4iLCBx
cF9udW0ocXApKTsNCj4+IC0JCXdxZS0+c3RhdHVzID0gSUJfV0NfTE9DX1FQX09QX0VSUjsNCj4+
ICAgCQlnb3RvIGVycl9kcm9wX2FoOw0KPj4gICAJfQ0KPj4gICANCj4+ICAgCXJldCA9IGZpbmlz
aF9wYWNrZXQocXAsIGF2LCB3cWUsICZwa3QsIHNrYiwgcGF5bG9hZCk7DQo+PiAgIAlpZiAodW5s
aWtlbHkocmV0KSkgew0KPj4gICAJCXByX2RlYnVnKCJxcCMlZCBFcnJvciBkdXJpbmcgZmluaXNo
IHBhY2tldFxuIiwgcXBfbnVtKHFwKSk7DQo+PiArCQlpZiAoYWgpDQo+PiArCQkJcnhlX3B1dChh
aCk7DQo+PiAgIAkJaWYgKHJldCA9PSAtRUZBVUxUKQ0KPj4gICAJCQl3cWUtPnN0YXR1cyA9IElC
X1dDX0xPQ19QUk9UX0VSUjsNCj4+ICAgCQllbHNlDQo+PiAgIAkJCXdxZS0+c3RhdHVzID0gSUJf
V0NfTE9DX1FQX09QX0VSUjsNCj4+ICAgCQlrZnJlZV9za2Ioc2tiKTsNCj4+IC0JCWdvdG8gZXJy
X2Ryb3BfYWg7DQo+PiArCQlnb3RvIGVycjsNCj4+ICAgCX0NCj4gTm90IHN1cmUgdGhlIHBvaW50
IG9mIHRoaXMuDQoNCkp1c3Qga2VlcCB0aGUgb3JpZ2luYWwgbG9naWMuDQoNCj4+ICAgDQo+PiAg
IAlpZiAoYWgpDQo+PiBAQCAtNzUxLDggKzc0OSw3IEBAIGludCByeGVfcmVxdWVzdGVyKHZvaWQg
KmFyZykNCj4+ICAgCQkJZ290byBleGl0Ow0KPj4gICAJCX0NCj4+ICAgDQo+PiAtCQl3cWUtPnN0
YXR1cyA9IElCX1dDX0xPQ19RUF9PUF9FUlI7DQo+PiAtCQlnb3RvIGVycjsNCj4+ICsJCWdvdG8g
cXBfb3BfZXJyOw0KPj4gICAJfQ0KPj4gICANCj4+ICAgCXVwZGF0ZV9zdGF0ZShxcCwgd3FlLCAm
cGt0KTsNCj4+IEBAIC03NjIsNiArNzU5LDkgQEAgaW50IHJ4ZV9yZXF1ZXN0ZXIodm9pZCAqYXJn
KQ0KPj4gICBlcnJfZHJvcF9haDoNCj4+ICAgCWlmIChhaCkNCj4+ICAgCQlyeGVfcHV0KGFoKTsN
Cj4+ICsNCj4+ICtxcF9vcF9lcnI6DQo+PiArCXdxZS0+c3RhdHVzID0gSUJfV0NfTE9DX1FQX09Q
X0VSUjsNCj4+ICAgZXJyOg0KPj4gICAJd3FlLT5zdGF0ZSA9IHdxZV9zdGF0ZV9lcnJvcjsNCj4+
ICAgCV9fcnhlX2RvX3Rhc2soJnFwLT5jb21wLnRhc2spOw0KPiANCj4gTmVhciBhcyBJIGNhbiB0
ZWxsIGFsbCB5b3UgZGlkIHdhcyB0dXJuIGEgZmV3IHBhdXNlcyBpbnRvIGVycm9ycyB3aGljaCBp
cyB3cm9uZw0KPiBhbmQgb3RoZXJ3aXNlIG1vdmUgdGhpbmdzIGFyb3VuZC4gV2hhdCB3ZXJlIHlv
dSB0cnlpbmcgdG8gc29sdmUgaGVyZT8NCg0KSSB3aWxsIHJlc2VuZCBhIG5ldyBwYXRjaCB0byBv
bmx5IGZpeCB0aGUgdW5zdXBwb3J0ZWQvaW52YWxpZCBpc3N1ZS4NCg0KQmVzdCBSZWdhcmRzLA0K
WGlhbyBZYW5nDQoNCj4gDQo+IEJvYg==
