Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BED635013
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Nov 2022 07:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbiKWGIu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Nov 2022 01:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235981AbiKWGIc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Nov 2022 01:08:32 -0500
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B80186E3;
        Tue, 22 Nov 2022 22:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1669183666; x=1700719666;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=STux5/4ZiUvZVovfKArUBbdnC1ZIgGpBx7+86J9/vVo=;
  b=ckg0NnGliQnjlecAF83QDHyoNyH312pjppKg+1wrH3lNuV0911PBhsrk
   J89Ch55YRdkEy2fKbvsAWxVlKpTo53l35YyYFTusmONPlUwBBvwh8L0yv
   J7/bPBPli8JqqKRmA5NU+cyLYtV4GVVHY8Mmd/xrQh6pRF/2Kbm8H8AFF
   yxH17FmKt1YX4Q5pPt8BSIJ4upPYvBSj384xYnE27rMMnn2tuud0EXTxm
   LmXGg46jwlmqqixap1DOeDDDyBBio3EEGFEm0CU8mP43ClFEhGvPDlvqY
   GP+liX9NIDCsr+1skIYMufSs+3D3POw/kiLkL1jMGmCxD8lyQRt99+L6g
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="70813728"
X-IronPort-AV: E=Sophos;i="5.96,186,1665414000"; 
   d="scan'208";a="70813728"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 15:07:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPXQN8+sWqbsfMK078V3/8KYVwPraP7dcv+3GwLUFW+coEamY2/A4xU5xFG+4QD6QVRYT3xyKTeAdRqTrwDZ4sR78ylaRD4gFkuFTy7hqe19fU1sWnGggauaUTMRDJcUkZBxJRlVlHEU419BWpug0NlDW2u06Hi05FfzUFUHrvt9nBSuc4/vM1xGFVUTQAR4DxrInoqdN6GSY1D0jUMGrkk7lsFgOV2BTgsYSQqEHdz18DpPg0VvaR8Z7xEwaHVzpeph4HPpW84aAaujdGZ9moQLzG45RVY+T7/BfDLEVlWNOcxd+l0MagLrsTVXQ81jhs4LQ+GtjlOj5YTWvNqMRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STux5/4ZiUvZVovfKArUBbdnC1ZIgGpBx7+86J9/vVo=;
 b=QAAiXBpW7r3f+7Oq5tl6wfKr268PooH0IUAswSCLALSSAfipqCa54UNddw6PXSyP5S4w4cqezr2auTvuwUD+4hja6pmYpG/KkKhzzNbgiMQbaHMGdoqQSP6yWFhpTdvv+Rkh3Ds0XEoGrc5+lXOxddir8ofzmzjxezH/5ociBrsYM5XgmojpBhQaPamSKKfIef79vSBRSmQDvZ+E+QAgN6mOMFMxO72wPxn5Qw8TO8iJDyfFIYILFlOP/CgX1Pe/kwfiNUWPvu8SFGYA40OymMirUSZOnQatGxPz04YPbkgfA2blSnsP6N7BuOp23Cz86vdNpr99rwnsTgu2wmj+Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by OSYPR01MB5333.jpnprd01.prod.outlook.com
 (2603:1096:604:84::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 06:07:37 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9%9]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 06:07:37 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Mark Bloch <mbloch@nvidia.com>, Tom Talpey <tom@talpey.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [for-next PATCH v6 09/10] RDMA/cm: Make QP FLUSHABLE
Thread-Topic: [for-next PATCH v6 09/10] RDMA/cm: Make QP FLUSHABLE
Thread-Index: AQHY+ZRI1TH8j3pp4UKX3oA91Nseoa5LEO4AgAD/qYA=
Date:   Wed, 23 Nov 2022 06:07:37 +0000
Message-ID: <9cf2a1c5-2334-dee8-8374-63453e23c5a3@fujitsu.com>
References: <20221116081951.32750-1-lizhijian@fujitsu.com>
 <20221116081951.32750-10-lizhijian@fujitsu.com> <Y3ziLoRuXFIOpnnl@nvidia.com>
In-Reply-To: <Y3ziLoRuXFIOpnnl@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|OSYPR01MB5333:EE_
x-ms-office365-filtering-correlation-id: ee15193f-f965-49ae-90cd-08dacd190581
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vjw/EUog3n6OLsPNZwFuuY/ye9qvOIupq5pxOjZUod/COddSenGTOTMxianf8QUMlTydIEOosJ1C7bjiRYZQmT42xHbc2E6b6hfmYrs1k5BH5xXXEsor8KOgPTBDcfb/Eb6lJbfQhJ2ln0Vf7oOUQl4R02p6AYvGQ9n/KmZxPJYXfg1nopJhCQySQQjHLzxYMJlDcwKclhGamPJAsY48WmCnSGcEQuRF9ulVOa0AWWkNRL6fZHgCKvJwCd+Whu5GPE2KuMDVFSfp+7rURyJTtWJO4ZyoUCqVtq4Gbmfj6+VQ9Zo7/7n/M10lrTT+02pdVf1Zov0Bokhtw63EC4VE3SdHqqc9SJBJAxNMi+Yr17+JFV+t8w8NeqllqNUNGOjBe9OkZLB+MUZZCwQSliiRJNTKaDH1UzdIFq1vZrc9Z7QSwjMBOBWkAkBj+pRTHTdv10l+EQH35ns9KeC+aloTEV+j8RhTlAwMVBSoJ85ruBRACx4be172s4oJDrK7Q9UMuLVwVQxajwmO2a2AE8acezulkxZkTObMwK2lv2EY3H48Yav2lZzgoYykIN1kiq1Nv6p3OrvT76EsDoiS55nPoisjp/2qGqllAzSSru4tjGT75rkun4kbBQX/pppPugdchXkS87UAg//dzGTS/wpLKps4OkXqvlOCgIt4igrDe1lcsE/sfrJVjDZ4gLsi2XYRtbkZp+82GCIXiQbQjTKH/x5XN2Xeqyz3kuM0IqA0YgLZ0gw91yHSjAB4LMIAqYZ3FKxkxp/VU0h9y6znnwELkxxj/bSl+ru0CH4Gs0XnaYY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(1590799012)(451199015)(82960400001)(122000001)(38100700002)(86362001)(6506007)(31696002)(38070700005)(53546011)(5660300002)(71200400001)(186003)(26005)(66946007)(6512007)(76116006)(316002)(66446008)(6916009)(64756008)(2616005)(91956017)(478600001)(66476007)(6486002)(54906003)(4326008)(83380400001)(8676002)(66556008)(8936002)(2906002)(7416002)(41300700001)(1580799009)(31686004)(36756003)(85182001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L05CREhjOW5SdHZQOFFsUFFHMnJQYWgyVlFQRWp1aEo3NHdvOTl3U3pDZkRs?=
 =?utf-8?B?TGhXOEJFMzdWYTU0VU9WVytNSlRpbUtvN3R0ZW5rTVRsMUJNOHdua2M5TVA4?=
 =?utf-8?B?SWZoWmE2dUUwZVp5eWhnOGl2TGVVTmtXWTVwaElVSzg5eWRwcTBGSVdNc0JZ?=
 =?utf-8?B?SmRPT29oSlZ0bDgyamNJVm1Xa1NLTVMwSU5sWG9oTXllYWJ4OEZsejNjYm01?=
 =?utf-8?B?WFQvbUVUcWh2RVZhWHBNVzNQWDRkMU5saXUzYW5aeUZpL0pJQkd1eEJIS01a?=
 =?utf-8?B?WWdsR1psbkdYcXc4S004MVpQU1dUMEpqVEpobGh6d0d6L3B3eWg4MkN6QlFx?=
 =?utf-8?B?Snd1dHB5UjBvVzFzakhTak5tQTJIbHpqT1pQMlZjYjNwT0RQMEZFaWVZd0ZR?=
 =?utf-8?B?WHpjVFJ0YWxBVE1UNHNzWGJOWXZKZ3NJdVIwWng2SEFyYnFFYXVZZjAyUm52?=
 =?utf-8?B?TmNrK2U1bjhzQkliRGNPWEVLSHRtL0FpbEFXT09PY0Vyd2JkcjBPN253ckhN?=
 =?utf-8?B?K3BmN0dPU2lZeSs5djE1d2YzZW10U1dhOTNjek1EU29IM1p0T3h1VGRvWW9K?=
 =?utf-8?B?TElWTXQ1WUV0UTFnYmdQUnM2Wm10dWdXb1RGVWliSUdURTliWVRtd25FdHFO?=
 =?utf-8?B?Ti9FaXRpT3hvN0N0ZDVHbWxzdUJGN0c5eU5hYm02amhjNGI3Rm9TWXNIWUYz?=
 =?utf-8?B?OTVlQlN4Z1FTUVpMemxOSUJ0R1NVbnlkZ1NHZTFhMG1uVldISVUvaDVoNnUw?=
 =?utf-8?B?QVpQQTBEaTVRRFBTZ09kMUVJLzBiQ0lrRjA0Wm1kSllab3lmT00zWEUrdjZq?=
 =?utf-8?B?YTJWSFo2dE9UT0NMV2kzRU44TWQzN0NYOTUwNEVsY3pwNFdldUlSNTlmeGhZ?=
 =?utf-8?B?SHE4TlpaNUFFcjU0a0x4VnFaOFROZlNlZVhaRkZGUmhxZVpDTU41b3Y3dDVL?=
 =?utf-8?B?YzJzeXh0U3hXbkJqdTRlTEROcVM0SXh0MUkyZXhIOEQydkhuQ0dqY3M2TVpo?=
 =?utf-8?B?OVZidndXNW92Z1lrWU1KVVNnSThkU2d0STJHL0RxeDFYVWYyZ3d2MVFEN3pY?=
 =?utf-8?B?L0FYcjlvZmRmL2hmVGFVRjlBNjdETDVJcjlUTDRPUHplckQ5ZXkzS0pwRVlh?=
 =?utf-8?B?U2toQmlKUWd0MHpjTWxTSy9OT3dFZll3eXpncEdNUHhSUUg5RnBDcmg0V2p2?=
 =?utf-8?B?MFRqc0xnR0xaZ1krVDBGcVozOGhlSVA4YU1ieHRiUTZUSU9UK0EzQjFXY0Ra?=
 =?utf-8?B?cmxoNk94RFAyN0JCdUl4dXozdzlMMWF0OHhhSk95RlY0NWhRZnRJcmV5aFI2?=
 =?utf-8?B?Z25nOWFOVGw0ZWxhN3BiY205dnJHeUkwSncvaTdRd2FpRTlDTlNiY1BsVkhE?=
 =?utf-8?B?U2ZaQ2tTcjk1YjFhRWg2bmp6OEE3TWY0blZHRUtKVGh1enoyais2akJzTDAr?=
 =?utf-8?B?RkhRUlRuN0pLZEZTYmZzUGVpY3pIQkZMeGtyR3hsMDZjR2NLaHkrM2Jta3RV?=
 =?utf-8?B?QWlua0VSU0loSmZlYmQwdUJoMnRZcUlqMDJPUk1JWUZORGRoU1pwYlRoR1RS?=
 =?utf-8?B?YkxPR3JLZkNTSWw4OHQxeDZNWlFRUVBld01JQUdSZnI5RTVqWjE4dmZkbTVk?=
 =?utf-8?B?VHlCbnJZWXhmS0gydXVybHZQaVIyV3lwNkU1YkxlUkRtTjJCVWlXQU9BMkhF?=
 =?utf-8?B?azc4akVQeURWa2tqTFBCV2dCeHRlV1pLejh4SVBNbHprVEZ2REtFeEZJUStK?=
 =?utf-8?B?d3VZZyt3aG9IcUNrOEJkaGdVbmEzNGJyaTFCNWdoTWlibGFmU1M0aCsrb2xH?=
 =?utf-8?B?Q2kwSVZBaDNIZ0VWN1pZUkJWUnBXbEt6ZmcwQzlBSjdSUXU3NTBtWjRPZTB0?=
 =?utf-8?B?Z0ZOdTFoay9JTXZxYkFlc1E0a1BXSE90SEJDMHEzN256Ty83RWZyZkExRFVv?=
 =?utf-8?B?RmF1VldEcFpLZDRacElFR0tUVmFybWJHVWh3OUk1OFlZVi9DandwaUlrSFpL?=
 =?utf-8?B?cE01cVpGU2ErR09McmVERWEwNUUvVEp0WEg4YXJtOTAwR3hqbmlUK1EzQ1lD?=
 =?utf-8?B?cUo4VjdwZnNKQXlRaUZJdW9SZ0swTmVaT0J0TlJGakorek51Z2RZWVBVWjh2?=
 =?utf-8?B?RDVodXNESlBwK09YUXA3ZHAwQmxTbFR2QUZkNGM5bkdWbE0wMWxwQmxqeTZm?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C0D5AD755C12B4D9FC755D76155AEEF@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YkE4Z2tQbWdoa1grUE9saDRhdDVQeDRYZVAwYWk4Y2t3Yy9xVDdaS2JWbEI4?=
 =?utf-8?B?OTkwUkpyZG5zVjU1M1FlRXh6Q0ZGNm9US2J1MkNjdEJjakU5cFJ2WDFXYldz?=
 =?utf-8?B?RU8xTlFOMGQreVhOZlB6MEhiZzNYWUhySW1sVjFBc1pqTGVkbE5nNXpCZUxq?=
 =?utf-8?B?SzNkMWhRbzF1K29SZjdVV2paRUVMQ1JEeldLOGExOG5IUnIyc1JFYXNEbGlB?=
 =?utf-8?B?TUgwREprVkNmck9nUjVPTllkQUtqb3hWNUxrUVZSUlhpSE0rcmZPRDZVeHhP?=
 =?utf-8?B?UFh4azNJNUFWWjR5RmNTTUgvZy82TWppWkZsTWUwWEdjRzBuZDM3Wmx5djBt?=
 =?utf-8?B?SmplVGxjek5CNHhjdjBLaE1lYXRjSWlDUWQzbDdVR1ErWUl0QjhJNWZXZjk4?=
 =?utf-8?B?RDI1MFl2S2Y0azRkcWgwYk9MT2ZxOTJFWEV5NjlxTzlqU0tzRnF1bnV5NHJW?=
 =?utf-8?B?d09JaGJhTWpYcUdFVjJ4YkV1amNPRElGMnl4T0dqTm5OVTVwem11SWttWDdl?=
 =?utf-8?B?RURKdmxNd1VlNElaWXJDS2hCUk54TGlrVU9MYWkxQzE4QzgwY3I5eDc1ZE9V?=
 =?utf-8?B?Q3VTYW11UCt1My9kV2dWOEZNNnVwWEN5TGZraEtVWExBS0lRYWNxNDNEZm9h?=
 =?utf-8?B?WDkxbitVQU5RdXM4bzgxK0haV3BtcmFUOHA3NThxNFNMdlUreGRHWTVhVDBs?=
 =?utf-8?B?b2Yvd0xpeVhCQTBYSXJLOEkwa3ltbTNXL2cwbmx3ejBOMXpwZC9NVGE4OVFS?=
 =?utf-8?B?dHUrZlpwcG5ybHB2bnppbjd6b01JM2VzRnovSGNYa1BqdXRvRmRTcUMyUDVV?=
 =?utf-8?B?dVZLZTRNVHh2NkdUY0R3Wi9qbGZrNFNYcER0VGhYRTh0UGFyTkZmTkIvdzRk?=
 =?utf-8?B?SVdxRUZXbG1kZzJrQytGdytLK0YwZno4OGpsaU5RZHYwaHdUVU9PVUs0d3ll?=
 =?utf-8?B?VUI3VHE3QXJjUjZTTzNRUUxwMnplZUpMb3lBdm40aFJ4UEtVTk50RUtJc1lT?=
 =?utf-8?B?dEQ0QnUyVm4rWW9DUVNCTmt1Y2pBaEJMZmdSenhXaUdxZ2lac3dDb1hKeVpQ?=
 =?utf-8?B?QTB4R0xHL3N3b1YrSytNT2hjMzFiNk1SVldtbVJGRzVUSnpMSk5NcUx1RlZQ?=
 =?utf-8?B?K0tYNWFvL1FEdURyNk9OeFNZZFh0VDhFR2g2U2J4STNYYk03TUI3L2tDNUx1?=
 =?utf-8?B?bVdCVElmZVltQmtOa1ZDams4RHQ5bzVPRUNiZ2kwUnptc3NmSUhlMXh3eUFK?=
 =?utf-8?B?WHhlMkg0MmtscnpnQWJ2Mm5kY0QrektDOFd4TmNiQ2xIa25mWlo1K25CTm8w?=
 =?utf-8?B?MVdmQ2I3TDJWWUlYM0kvNDVWd2hRL0JOek5WVy9mM0xIREJRQWJRbUE2cWNu?=
 =?utf-8?Q?/Lz2Nk6cL79OsjFAWCCYiBF+MGxGjhVE=3D?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee15193f-f965-49ae-90cd-08dacd190581
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 06:07:37.6443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WT/CiYzYWOretHmvkCoFsN7v40Iw+faRi5Z+f+b7+JZZEHOzQKaEI5u1vHkZ94A+7kFo4uFGmyPgqEajULfgDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5333
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDIyLzExLzIwMjIgMjI6NTIsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gV2Vk
LCBOb3YgMTYsIDIwMjIgYXQgMDQ6MTk6NTBQTSArMDgwMCwgTGkgWmhpamlhbiB3cm90ZToNCj4+
IEl0IGVuYWJsZXMgZmx1c2hhYmxlIGFjY2VzcyBmbGFnIGZvciBxcA0KPj4NCj4+IFJldmlld2Vk
LWJ5OiBaaHUgWWFuanVuIDx6eWp6eWoyMDAwQGdtYWlsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6
IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCj4+IC0tLQ0KPj4gVjU6IG5ldyBw
YXRjaCwgaW5zcGlyZWQgYnkgQm9iDQo+PiAtLS0NCj4+ICAgZHJpdmVycy9pbmZpbmliYW5kL2Nv
cmUvY20uYyB8IDMgKystDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUv
Y20uYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtLmMNCj4+IGluZGV4IDFmOTkzOGEyYzQ3
NS4uNTg4MzdhYWM5ODBiIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUv
Y20uYw0KPj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY20uYw0KPj4gQEAgLTQwOTYs
NyArNDA5Niw4IEBAIHN0YXRpYyBpbnQgY21faW5pdF9xcF9pbml0X2F0dHIoc3RydWN0IGNtX2lk
X3ByaXZhdGUgKmNtX2lkX3ByaXYsDQo+PiAgIAkJcXBfYXR0ci0+cXBfYWNjZXNzX2ZsYWdzID0g
SUJfQUNDRVNTX1JFTU9URV9XUklURTsNCj4+ICAgCQlpZiAoY21faWRfcHJpdi0+cmVzcG9uZGVy
X3Jlc291cmNlcykNCj4+ICAgCQkJcXBfYXR0ci0+cXBfYWNjZXNzX2ZsYWdzIHw9IElCX0FDQ0VT
U19SRU1PVEVfUkVBRCB8DQo+PiAtCQkJCQkJICAgIElCX0FDQ0VTU19SRU1PVEVfQVRPTUlDOw0K
Pj4gKwkJCQkJCSAgICBJQl9BQ0NFU1NfUkVNT1RFX0FUT01JQyB8DQo+PiArCQkJCQkJICAgIElC
X0FDQ0VTU19GTFVTSEFCTEU7DQo+IA0KPiBXaGF0IGlzIHRoZSBwb2ludCBvZiB0aGlzPyBOb3Ro
aW5nIGNoZWNrcyBJQl9BQ0NFU1NfRkxVU0hBQkxFID8NCg0KUHJldmlvdXMsIHJlc3BvbmRlciBv
ZiBSWEUgd2lsbCBjaGVjayBxcF9hY2Nlc3NfZmxhZ3MgaW4gY2hlY2tfb3BfdmFsaWQoKToNCiAg
MjU2IHN0YXRpYyBlbnVtIHJlc3Bfc3RhdGVzIGNoZWNrX29wX3ZhbGlkKHN0cnVjdCByeGVfcXAg
KnFwLCANCg0KICAyNTcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IHJ4ZV9wa3RfaW5mbyAqcGt0KSANCg0KICAyNTggeyANCg0KICAyNTkgICAgICAgICBzd2l0
Y2ggKHFwX3R5cGUocXApKSB7IA0KDQogIDI2MCAgICAgICAgIGNhc2UgSUJfUVBUX1JDOiANCg0K
ICAyNjEgICAgICAgICAgICAgICAgIGlmICgoKHBrdC0+bWFzayAmIFJYRV9SRUFEX01BU0spICYm
IA0KDQogIDI2MiAgICAgICAgICAgICAgICAgICAgICAhKHFwLT5hdHRyLnFwX2FjY2Vzc19mbGFn
cyAmIA0KSUJfQUNDRVNTX1JFTU9URV9SRUFEKSkgfHwgDQogDQoNCiAgMjYzICAgICAgICAgICAg
ICAgICAgICAgKChwa3QtPm1hc2sgJiBSWEVfV1JJVEVfTUFTSykgJiYgDQoNCiAgMjY0ICAgICAg
ICAgICAgICAgICAgICAgICEocXAtPmF0dHIucXBfYWNjZXNzX2ZsYWdzICYgDQpJQl9BQ0NFU1Nf
UkVNT1RFX1dSSVRFKSkgfHwNCiAgMjY1ICAgICAgICAgICAgICAgICAgICAgKChwa3QtPm1hc2sg
JiBSWEVfQVRPTUlDX01BU0spICYmIA0KDQogIDI2NiAgICAgICAgICAgICAgICAgICAgICAhKHFw
LT5hdHRyLnFwX2FjY2Vzc19mbGFncyAmIA0KSUJfQUNDRVNTX1JFTU9URV9BVE9NSUMpKSkgew0K
ICAyNjcgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIFJFU1BTVF9FUlJfVU5TVVBQT1JU
RURfT1BDT0RFOyANCg0KICAyNjggICAgICAgICAgICAgICAgIH0NCg0KYmFzZWQgb24gdGhpcywg
YWRkaXRpb25hbCBJQl9GTFVTSF9QRVJTSVNURU5UIGFuZCBJQl9BQ0NFU1NfRkxVU0hfR0xPQkFM
IA0Kd2VyZSBhZGRlZCBpbiBwYXRjaDcgc2luY2UgVjUgc3VnZ2VzdGVkIGJ5IEJvYi4NCkJlY2F1
c2Ugb2YgdGhpcyBjaGFuZ2UsIFFQIHNob3VsZCBiZWNvbWUgRkxVU0hBQkxFIGNvcnJlc3BvbmRp
bmdseS4NCg0KPiANCj4gRG8gZmx1c2ggb3BzIHJlcXVpcmUgYSByZXNwb25kZXIgcmVzb3VyY2U/
DQoNClllcywgaSB0aGluayBzby4gU2VlIElCQSBzcGVjLCBvQTE5LTk6IEZMVVNIIHNoYWxsIGNv
bnN1bWUgYSBzaW5nbGUgDQpyZXNwb25kZXIuLi4NCg0KDQo+IA0KPiBXaHkgc2hvdWxkIENNIHNl
dCBpdCB1bmNvbmRpdGlvbmFsbHk/DQo+IA0KDQpJIGhhZCBldmVyIGNoZWNrZWQgZ2l0IGhpc3Rv
cnkgbG9nIG9mIHFwLT5xcF9hY2Nlc3NfZmxhZ3MsIHRoZXkgZGlkIGFzIA0KaXQncy4gU28gaSBh
bHNvIHRoaW5rIHFwX2FjY2Vzc19mbGFncyBzaG91bGQgYWNjZXB0IGFsbCBuZXcgSUJBIA0KYWJp
bGl0aWVzIHVuY29uZGl0aW9uYWxseS4NCg0KV2hhdCBkbyB5b3UgdGhpbmsgb2YgdGhpcyBASmFz
b24NCg0KDQpUaGFua3MNClpoaWppYW4NCj4gRXhwbGFpbiBpbiB0aGUgY29tbWl0IG1lc3NhZ2UN
Cj4gDQo+IEphc29u
