Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7D97D8CC8
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 03:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjJ0B0Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 21:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0B0X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 21:26:23 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BAA1B6
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 18:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1698369980; x=1729905980;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0ous5r1vbIHq4Cp2ywI4ZI4+7BFVzFzBoHWEbgkqWLA=;
  b=tH0VI/4WJEzIZgA4HnV+Ko7ytFy8lCncxN5MAwbEqIYXJaLgmz92Wnzg
   +Q7t7LQhTiQ2WzZdIynupBDu/n46hTUh0n4yijqQ+yQ3kLKuQyiA1JEcE
   lpAUpwtxSZ4K9wRrtN9eFIXAZOx1obZsXQmRgAsvMmr5zN1WLbRUgUL1u
   7IP8J02zo1Qti5TknSxcF3FZbzLBjaX0jWrB2BP0wFU8i9n2vkPExRLsm
   I67Fbj7Trck6J8LC4akbbjQ1BUtL8Xv6FGEy+VY1jur7d+hDIY8dQjb9T
   nnwg+2wwV7ae0IOvWOIYlk6POWT7cGmvU9j8BhLaCIDgYtIfxKzXuEMM0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="100815569"
X-IronPort-AV: E=Sophos;i="6.03,255,1694703600"; 
   d="scan'208";a="100815569"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 10:26:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOQvvXGBebh4EaslBDGtq6v5z0F+p8j0xqR5JsbAA24hVU5kvu0+iEnkgQ2n5u3bK61EERoZ6RfVjy5jDnsDiZRLS9ZKEAkzyeZy8xGQz/WICJyA3FL4JknfJIAYBVLZKU4WS3ZeBYCYIophyZFWTVvZZjpRBplVDuT82osqyogRx9+4uMI0SHCTrvZ1mIb45/3XZ1JTXYLKv3J8SXxHXuju5FXQ2PEh0jlRUO0X92iHcgXq25wCVuqqD5yFH4Fg0ZJ11tLQKlkBcoDzfs1u1TaXwernIwY70KkP1Hzbmz9B+hBd4ZNYJthvel4MAup3eWlcn+cTA3EqwD20tS0jJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ous5r1vbIHq4Cp2ywI4ZI4+7BFVzFzBoHWEbgkqWLA=;
 b=nz28cPEOVFwqi6XpRua9CHRGhPuvsqid2bHqPaoVCtfxasiPyhZ5n4YMv1AdUNxDLfKxCgJaSu0abdNtnQM7XPvTKsNojhTuMkH9XRXhj2nOtFC9d3EM6b74DD1y7WOlHPuncJaJS9iIH+SBLWqTwk1doJC32xnfiIRlSQaqzw5ME4Nx1S+6ZeBhxBb8tUat2DgHmFEHlgcwlSw+Qn3nMCjG5b6b+vYUTRMOj7sc4PDA95yPFpe/XR/wG5tkwvr1v2xn+TlWZArt5/v3vkJ30CEohI0a3NHDxPYMPI4Bj7AUYJd5idW0uS9lrC8qs8sb72b79D1aCqVBzoQ17Yl6nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by TY1PR01MB10817.jpnprd01.prod.outlook.com (2603:1096:400:325::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 01:26:12 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::146e:a9f0:503b:f051]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::146e:a9f0:503b:f051%6]) with mapi id 15.20.6933.023; Fri, 27 Oct 2023
 01:26:12 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Bart Van Assche' <bvanassche@acm.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
Subject: RE: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with 64k
 page size
Thread-Topic: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with
 64k page size
Thread-Index: AQHZ/XL92/TSgxYyx0mXQnQUi6BiibBHQm7ggArS24CAAKu1gIAEDMEAgABzewCAAWh2AIAAEBeAgAMikACAAElpgIAABAUAgACHZwCAADYAIA==
Date:   Fri, 27 Oct 2023 01:26:12 +0000
Message-ID: <OS3PR01MB9865DFC2FE195813D2330DD3E5DCA@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <20231013011803.70474-1-yanjun.zhu@intel.com>
 <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <a6e4efa6-0623-4afa-9b57-969aaf346081@fujitsu.com>
 <20231020140139.GF691768@ziepe.ca>
 <6c57cf0d-c7a7-4aac-9eb2-d8bb1d832232@fujitsu.com>
 <CAHj4cs86fFi+1LMMAzjcdGg1g1gbQwy6QgksC0kYVmNgghLV_w@mail.gmail.com>
 <1ffaeaa4-4ac2-4531-8e0c-586e13c14c97@fujitsu.com>
 <366da960-6036-49c5-ad47-3ae3f4e55452@fujitsu.com>
 <8f705223-6fde-4b29-880b-570349f40db8@fujitsu.com>
 <143f03b7-08ba-411c-a7ad-580141c06cfe@acm.org>
 <20231026134300.GV691768@ziepe.ca>
 <fa4fab22-4d59-43f8-883c-d5a70a69a964@acm.org>
In-Reply-To: <fa4fab22-4d59-43f8-883c-d5a70a69a964@acm.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9YTEyNzQwMGItNzc3Yy00ZDk2LWI4NDEtMjE3MjQ2NWE5?=
 =?utf-8?B?MzYyO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0xMC0yN1QwMTowMDo1M1o7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|TY1PR01MB10817:EE_
x-ms-office365-filtering-correlation-id: 2b38e9f3-89a0-4415-028d-08dbd68bb498
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 31gJPUm+ix1wTQCGRQm6LVDwIFXnmttEK0upY/NXEr2B7uTKSVvhEFYIcu/JJtJo3c7yckhI9Kn5Zecu+GdVMt75uoKm6zVmwqVm7lXMAzt5r3PjE+8Z5Fz0CnJWAjFxSShoghQVwC3mUAiXy8yt+3I95Cvbdxbmh+TP/VI5bbqeBwVEX0zpZIk6d4QCrihFUlFyWNlnoblIbspxiAEQZpmUj49Tk7WoV9eMpsl6WjHz0uW6rMgLKgTgye0ut2vuDoo5QJSOSjp8kdJsdZQkhrEfcM69x2c5wjKMwn2JBOYBVCru70Guh9hbNe1lmgOsNs/oJVqwmuME+stH4Aupxwj5WqeNFSSxNDSaVIc6VE9BvQVGQPRvuMz1uxlIZsUHMZ6MENaM2KVNyQNX/s3SIPH56hv86kqUwqS9fk8vz5S/Ce8zrdwyVREn61Qajp1dlzXA2PoPqeXdSG36ISWlHxnCyHbHHMBqVJl/xlpTxgzY0zZrzBh8Wbv/Q47Y9SzOac0cuUXdtGKhD9h9BXXZZGodQU6CKd8FoNReV9fYHcBp/TcprxISy2RYGarQcRml/z3HDWOwoul9Ns+4QZZe+vGjBsZzcdmwrq9RUblnLCfzrObp59Fw4zHZm+v/zzRB9HYVvVIFv2x5TLIkUdhuZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(1590799021)(451199024)(1800799009)(186009)(316002)(5660300002)(52536014)(8676002)(8936002)(4326008)(6916009)(4744005)(2906002)(38070700009)(66476007)(66556008)(76116006)(54906003)(55016003)(66946007)(66446008)(64756008)(1580799018)(478600001)(41300700001)(82960400001)(38100700002)(33656002)(6506007)(53546011)(7696005)(9686003)(86362001)(26005)(71200400001)(85182001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1VsQXFVWkM4enFGMTREK2Q5RW0xa1ROQXJUQ250dGZzY0dwM0E5cnRRemcz?=
 =?utf-8?B?cWlUZTQ2SmZ0WDhLMjhPNHhWUVJ2dmdrM2xuRlhlckRGWEE1b0Ura3JsaitZ?=
 =?utf-8?B?clN3VDlUVDFSTGNHUjRuZEt4VFhyZXI0VC9pdGRKR1pmdXc4aWxleGJWYTB5?=
 =?utf-8?B?Y1VmeTZvNXdLd0laSjIwTTROV1o4RGtpdEh5cEowdWZUOVFDdkovaE1kSzZN?=
 =?utf-8?B?UndORmsrdmVJSkFoMkhLTGw1MjVoOWVQblhWRmFUaHhxSWk5SWRIQWIzQkJC?=
 =?utf-8?B?amhLdUVqTzFLZjFQUlVJTUlVL0NObUZIYU56V0I3YjdsWUQreTN1ZVltU09t?=
 =?utf-8?B?bFRGSDdjdnFrQkNKc0hoWW9rZ3JpaUJTVkFFLy84bHVlVjk1TVBURFNrM1Y2?=
 =?utf-8?B?VGVUTnV0dmk0Qm5IQkNEZUNmRmF2WkJ5Q0RVQVZaU1N2SXBZU0VWZ3dqWEpM?=
 =?utf-8?B?ZU14NExXRXpBRnltd2I2MEI1aC9YUGxBNlZmKzVDbzQvSVU3aVJmUnhhL1NE?=
 =?utf-8?B?WlhtLzg0TlIweEJjNVE4N2I4cXhYWDZaVnBIU1IyWlFZT08wbnRUZFpxS0w5?=
 =?utf-8?B?c2xsdUtqQVllRDdhWmpDOWN1Y2h1Kzg5V1cyRlFWYkl2QmVuUkhEenpKc2xB?=
 =?utf-8?B?N2VFTUovMXFrQWdScWcrVHNrK2ZTb3RwR0N1NThXME0xYThKVUg4Wm1peFEx?=
 =?utf-8?B?djZMazM0S3dIK0M2bFF1dmp1L0VtTm1hejI3aGs3VXJXVGEyNVpHK2lRR1B2?=
 =?utf-8?B?TFpUMlJ3WG5vNTY1OXBCZmZxY1MvSlZjM1E0VG9FZmJUVWZMaGcrN2xhNzU1?=
 =?utf-8?B?bTl0Yjl5RGJZQ0FzMEJUVDQzZnNOREJ5Sk8wS2w3Uk1vQ3Qrbm9qbkZpb2J6?=
 =?utf-8?B?UUg5NmFlRDZ1SUpRbURLVllINE5QSWN3UC80MXRSSTZKQmJNOEFIMXdNRCtz?=
 =?utf-8?B?S0o2YTlYVERWNTJoWkZGVjNqM0JqK0YxS1VDRGc0YWtNajRlbHJ1TmQ1ZHJq?=
 =?utf-8?B?MDd5U1dpUmdNUVk0dWdxQ1FXUFZVdzFyeUhveHJnbU1xT0hMOVlwRjBBVDdW?=
 =?utf-8?B?V0t2cGRCMExSazkxUllMcGxWRlJYbWFwdnVkajBweGxxc01NYXRWcmhVQmpE?=
 =?utf-8?B?MHN5Z1pRUnV1bjg3RzlUMnI0bW55bG1EaDlSZWFwMjB6VEJxTlhaTE16TWxz?=
 =?utf-8?B?cEJUV0M4a09kdlpaTFNCcHExajhPajlTbmtjeXBETzlDODc2N2xlcHJFeHJx?=
 =?utf-8?B?c3JEZnFZZk03RGNpQnpLMnBUL0FRYVlEQjIxWTZFVldMTFdVVTNRNURaRDVW?=
 =?utf-8?B?THdJaEhtVFRCbitGdU92SU5oSFloRFQyeGsrVTVMT1pabW5pZFREKzVJZWxo?=
 =?utf-8?B?dHhhdUxwaHVjNGFnWndsMXpJUlZWVG01c3QyMHJDMzMybzNORTB0SHhCdTNx?=
 =?utf-8?B?ZnVNUkRhQlRER2hqTlFIWm9NU0J6UG5HZGxDRDNrLzhzeGQ2T3RaeDhvSzBL?=
 =?utf-8?B?QzFLUUJRNUJIck44SUJVeEVvL2grOWhjZDdjcVlmSWY1aGZzSFBiQkxYdDVC?=
 =?utf-8?B?L3NmS05EbTNTWnJuUXZrbXV3R2ptME9EN3g1QkM0TnBERE1TdmFVaFl0UFIv?=
 =?utf-8?B?TTYzU0JlSE5leElZaytJcmlCSmwzSVdmVDJjeHdLeENsbU1nekIyUjJ1U3JP?=
 =?utf-8?B?MWJFZ25HOUlXTFhvbkhtNTRSSG05d25YbVpkOU9QdlBLd25yWDk5WFRBbUtx?=
 =?utf-8?B?WUI0QkY4aitHVlNEcUI5N1hLVUxGMGZvOC9SWTVzc0NWb3VMRGFzRVFDR01y?=
 =?utf-8?B?UEFLUVVoODVtdXA2dWkxbS9WSFdvckkyRnJpcTllWlRqaE1xcE96MjU1bXZD?=
 =?utf-8?B?RmREV0RNVTZMTHhpVmtybDhlRVR3QmgzaEJpK09qcXhjMnBXdkVud0kyTVNZ?=
 =?utf-8?B?dEh1c1RncWV2SHdEN0pqSmR3SjVabVdjZHN1UDQyakEzOU1jM2FPbHY0QWxO?=
 =?utf-8?B?MUJRaHpJZHZDQ3d4TkNzQ3FMTzRRWkVjQ21iaHF4TzF5eWJMWXpJczcxRlF1?=
 =?utf-8?B?b3pNWUU5SXYyeHQyUXZZMVhIS0lMcVA2ZGRIM2Ewa1lTQ0hKNFRWRldUNDJy?=
 =?utf-8?B?UjduRUp5amFNTGYzaGNCYmZEMkpLVEsvMkFadHV1S0d4cDI4eFRLNHQ4RUJN?=
 =?utf-8?B?dHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VmhTU0RLNS9ReUlYZTg5Y3VmVzR3aEJpK0NxWjh5UnF4K1VEbkovK3pmN3N3?=
 =?utf-8?B?aTdMUDlLUHFkWXN0emJ1eklzenQ3NlByN2xlNzlKL1k4emJMcDNJSzF5OXpY?=
 =?utf-8?B?R2RlOElPNTl0ZWYvMUg0dVB6NWw1Ym1xUlVROWdiaXd6WHFLSEg0MUZvbU1k?=
 =?utf-8?B?NlhOR1VCVTJIL2g1eVFObEU2czkrUTR3aWNnaE50bzlDUnVQT3dXSU5MU0di?=
 =?utf-8?B?TGpFSHpWM1ppR2d5N0tJdW50dDFRcmZVTEc0RFlBcVhhVGtHMmVPSUMvQ1k1?=
 =?utf-8?B?WTVjTkVTNHZiRzRhN08rVWxqUlFIYUJyQkI4TmtzMTlhRW5Od2xMaHB6Qzd0?=
 =?utf-8?B?WVZBTFcrOUR1ZVl6RWxOU05CZkdCOFV3Rm9ha1o2MXBrZDVKQW11U2o4QWY2?=
 =?utf-8?B?ZXJMM3A2ZmVFQ25QRlMyeGtNT0FsZjhCR0RiYTloNHVtRW5ONU4yei93dEtH?=
 =?utf-8?B?U0FwL09OZHRIc2x3dzM3ZzVTWU05T3I3NWtQNWtTcy9ZNFM1djFzVWUyQnRS?=
 =?utf-8?B?MkhkTDRKK0M3RlZqVG9zbDVadVFBQ1R4c0xGNzVDQmdFZzV2Z3JoNTl4b2VB?=
 =?utf-8?B?UWQ4cFFUdVJ2WVluSENrMVVjdFNOSXB2ZGw4WitaWGZTSm5xUTllZncyNlNh?=
 =?utf-8?B?VFlUdElCOTNCWGZMS2Nmc1NoazNScnN1NE80UDFyTDFHUGdjVEw4bzFSSmkx?=
 =?utf-8?B?YndoQWhndGZlTkM4UncwenlmT3Vrc1BVb25EdVJTNFlMUi9ZdGJWNkR5VExi?=
 =?utf-8?B?WjVvTnREZG9PUE9GZFkvbFZYaENQSEZoNzN6RkJIdFVFejJ1azNoeSs4M1M2?=
 =?utf-8?B?S0pTaXNEbGtURHRLclZaZXVYbmhacWd3bHVjcnd1Q0pxUTl2YTRpVFNZanpK?=
 =?utf-8?B?N2NpTWFGeTZvSi83RFpuQnBLaFRFVzBFNXF0UzBEZ2dHUVhTSUhhNWRsNHZR?=
 =?utf-8?B?bG05WHhpOTBoS2VVWmhraE1YNkJSVWc1NngrVFY0Qzl0TmYwZ1VjRmtUQTZh?=
 =?utf-8?B?SGl2NHo4dDE4cjNGMktHZlN0dWhHbjY3WnlLK1pNK3c1eVRQZ1Z3K3lQVDNM?=
 =?utf-8?B?THN5aE1QSjNjWTVRVjU5RUdUbkt6YmtBVGNmbVNvbHZvZHhtbThiQzJFcEtO?=
 =?utf-8?B?WkF1M0tVSmRlQm54ZWprMmQ3WFRNTEhKc28rbXIrYlV0SEh3WmNpZVppWTdU?=
 =?utf-8?B?WmlDenhtUlFKVDlPZzRBa0Vua0RMTHdVZEtIb2JjTFRQTXJjZWpWcmxCVS9w?=
 =?utf-8?B?UTNpbDd3Z1Y2YVZDVFFSN0cwRjVyRDNyNmlPa3BjYXU1RkdxZz09?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b38e9f3-89a0-4415-028d-08dbd68bb498
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 01:26:12.1360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjhSuiKlVatFP9WBUadUTiMEKLXuytE+GujwdybV40S+u5+3HXJ6jSudTvunR0oWDgiC5p1mIZBtwc+aLPKo8UmyQAwFBPjHU7zQZJbQr0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10817
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T25GcmksIE9jdCAyNywgMjAyMyA2OjQ4IEFNIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gT24g
MTAvMjYvMjMgMDY6NDMsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gPiBPbiBUaHUsIE9jdCAy
NiwgMjAyMyBhdCAwNjoyODozN0FNIC0wNzAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+ID4+
IElmIHRoZSByeGUgZHJpdmVyIG9ubHkgc3VwcG9ydHMgbXIucGFnZV9zaXplID09IFBBR0VfU0la
RSwgZG9lcyB0aGlzDQo+ID4+IG1lYW4gdGhhdCBSWEVfUEFHRV9TSVpFX0NBUCBzaG91bGQgYmUg
Y2hhbmdlZCBmcm9tDQo+ID4+IDB4ZmZmZmYwMDAgaW50byBQQUdFX1NISUZUPw0KDQpTb21lIGRy
aXZlcnMgcGFkIHVwcGVyIGJpdHMgd2l0aCAxLCBhbmQgb3RoZXJzIHdpdGggMC4gSXMgdGhlcmUg
YW55IHJ1bGU/DQpJIHRoaW5rIGJvdGggYXJlIHByYWN0aWNhbGx5IGFsbG93ZWQsIGJ1dCB3ZSBz
aG91bGQgdHJ5IHRvIGVsaW1pbmF0ZSBpbmNvbnNpc3RlbmN5Lg0KDQo+ID4NCj4gPiBZZXMNCj4g
DQo+IEJvYiwgZG8geW91IHBsYW4gdG8gY29udmVydCB0aGUgYWJvdmUgY2hhbmdlIGludG8gYSBw
YXRjaCBvciBkbyB5b3UNCj4gcGVyaGFwcyBleHBlY3QgbWUgdG8gZG8gdGhhdD8NCg0KSXQgbG9v
a3MgQm9iIGhhcyBub3QgYmVlbiBpbnZvbHZlZCBpbiB0aGlzIHRocmVhZC4NCg0KVGhhbmtzLA0K
RGFpc3VrZSBNYXRzdWRhDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+IEJhcnQuDQoNCg==
