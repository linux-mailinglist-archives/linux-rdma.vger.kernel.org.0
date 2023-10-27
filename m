Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A627D8E40
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 07:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjJ0FoG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Oct 2023 01:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0FoF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Oct 2023 01:44:05 -0400
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A13F1A7
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 22:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1698385443; x=1729921443;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HYHwoxv576nURViuFSU+Nbl9CcFH51yZvUkuiDBfIuk=;
  b=R+/8hbyfrPUTzmeh189DNcQT/5DyG8XtCiRgaWDp7cUfz3oDH4Q5SIas
   ceCKV/T/aXlvlPtDaiNF/Dn0Ypo7tXv0xWPm3aMAcVfpb6Hqh3Qm1Eqil
   i2UrMYZbTyVgrc9T9XQFypTxBeMiaRI++WzdmpGeOclxl6udOTjH5xglJ
   0j4CKgRzTOA26ApT2FsH/MoGC/fORVI7sKMCwNLEQ/pRPpHhR6YYMuwkT
   GffRkq+AW5OQ/h4NCXPuQKy9O3mmdusqbuSfCJ0Q6TonZYfcYjxER/Twf
   Dh4kNAk3Fl1ypCr7Uos8cXq1hjBoftsRqhOW0sZTjzgkWk+XAYsalKpVq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="11789837"
X-IronPort-AV: E=Sophos;i="6.03,255,1694703600"; 
   d="scan'208";a="11789837"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 14:43:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4PRhIjUM4zU+C08pkd4M3C5UUoEDT7pmsMUUxluqIAE4p3FDXj2DMiwg4Clh47EwNeEytheco5Tss6mPaHrdUAB348bfqBe9rm+sn8tqpJNFgHjZBO0uLzh7NOOg/Eflta8AmdkIYNNeuNSRj6GuTjk20s1lVtF5dlJs+sk7ghjhR0ZzaO1ZYV7YQD7m7mTTWOF5NTxXqVEuFBo5EbWCTrumE72010naX0ewPACxpOaJru/CfSovS56akZ7HWiqDRAtA0O7/0we76yt9K2OLLStxOfsPjT1e1SLcUQyDFKjWHadvmNQEaJ/3VCzs9h/fuwxZ1bGHWgJ+7HnIjtZ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYHwoxv576nURViuFSU+Nbl9CcFH51yZvUkuiDBfIuk=;
 b=c0oTuttYe6PYpImaVWuxmHykMpUUjh2j0X4yyJ2nQNZzjkjXAwsujgux/5quhnjW9QvAi5Pxtot0Dh1SEwBXYUKQenZeudJt9fJs2WyX/AQ1AVkzEWvT80oyXTpy8ZebH5eIcGBuNnSI5iUTlP4sbppYEra3wdPlWu/eHS4EJdAOFrTA7ZnyL+3hT6ItCT0lq9EErXRau6FLJ5xeRTJsFejCqdjNdyucYuss9d1BbT1iEuXgq0D2KoBViPvPd/zTwtqyXBpeg6RTpXEdGbuconWocWiFXJsoleLh5QfsyDxxZlU2gYGddfhda81d5jIB5QYRoLPIbZSuQUrR5HIuZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by OS3PR01MB6088.jpnprd01.prod.outlook.com (2603:1096:604:d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Fri, 27 Oct
 2023 05:43:55 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610%4]) with mapi id 15.20.6933.022; Fri, 27 Oct 2023
 05:43:55 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Yi Zhang <yi.zhang@redhat.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with 64k
 page size
Thread-Topic: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with
 64k page size
Thread-Index: AQHZ/XL9IGMvq9FNfkyOpi5jnlhbgbBHnzQAgAp2EoCAAKu4gIAEDL+AgABzfQCAAWh1gIAAEBYAgAMikICAAElrgIAABAUAgACHZwCAAIUSAA==
Date:   Fri, 27 Oct 2023 05:43:55 +0000
Message-ID: <06812c06-6b57-46c8-9b12-69f679bc2573@fujitsu.com>
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
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|OS3PR01MB6088:EE_
x-ms-office365-filtering-correlation-id: f451f52d-bd99-4869-cd50-08dbd6afb59a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HXnJQq6ajsAyPVoKkWPVgS/heanyFzHrxXmVmOL0G4MtescI/3G9sEJDWNzN3Gf6DdEjIVKskhsFgOMjdziFhh/N0d4WnzyRzZUxKN/L/N7L6VPMhNw20IOgg/+ICz5op4TDuPV1gf+d0QEuaVeWIATFFeTHLjynEni6H5VyhxGdjG3qp8Cp53NDGvYoEh/M16Q32xzLnhnM+HK4gz0SCW4fA/Ijw+NyYSID81X1zgvJMlO7PYvExp/XwTkxNoeskxUyYhutzaqHk8ZTOBU91Lqw+MzcoioeZsMWP8OUawWoE20SQDhrtSRTER6Zb6Qno47Nw9W+TTq3b8ziN3BRQDRzixRbKxppEuL2r/JDIK51/3THhgPUpgqtN+E1X6olH+oHcPde35sBj7HwzR5HYlbW6mBiljXyMSFJT90+Td0sw6hu0C31j4S+zSEJR+/5e/20ZJesE6nNSzTz/phTjkXDZRwTEmcZYCACthL3Ftuf6z2BR2n79g/EFn7xctIvLN66eNMbF9msFSx0QrlpWkma2Z8JEFysUqMYg0uH/sAacc7De1+GpehSwilEKY9ptYXxkj+WfIXnAHTN37FsTpJzO9fPdc/9tJZ273NIH/IvZN0K6V8z4/KLPj1Lad/DM4cbClY5THKJhXaCWyvZsDFvdbiW4Eh6MhC+Uon7tK0u8B2AfdAmQX5b78Xzt6ASZoQASj1OG/MFuzY98o6FAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(186009)(64100799003)(1590799021)(451199024)(1800799009)(66476007)(26005)(1580799018)(2616005)(38070700009)(82960400001)(38100700002)(122000001)(36756003)(86362001)(85182001)(6512007)(66556008)(66946007)(64756008)(8676002)(4326008)(8936002)(54906003)(6506007)(110136005)(91956017)(41300700001)(31696002)(5660300002)(4744005)(31686004)(2906002)(316002)(71200400001)(66446008)(76116006)(53546011)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUJYUlpxdVZMNGVoYjV1S3lzWitZVTBrM29odVlVR1FsdjcrSkhVb21FaHRR?=
 =?utf-8?B?Wm93WmxXYk9hSlAxNnhlVjdpVnhmRTNRVGp5eFVVWGRCeTNwUFMxK1RDMFhV?=
 =?utf-8?B?ZWZrdG8wT0dGZDJETmpkN2x2WS9OUzU5MHZKSW5uakYrSnY1VSs3K0hlU1FB?=
 =?utf-8?B?RHd1ZjFCeW1CZldyUUNwejBEVEpNUW8xVFN4OXZqRk0rMm5rMlIwQmRRK0NU?=
 =?utf-8?B?RGFIcGxjK3UrQzBOUjJGQ0tnTHVZMUhlUW1kWHo4QlVLMytlbHF6NVpPQ25u?=
 =?utf-8?B?TnNneGYyeDU1RnpQNjNRbXAxbzYyTVVLVi9iNk01c2J6Sm9hb2YwVE45NmNi?=
 =?utf-8?B?WjV3cFJUUGYvVmpwbFp2aCs0bHpNMm1iT1BXUWF5ZDdxeFFBNExWK0M2bXRI?=
 =?utf-8?B?VUorR29MT042ZElmQ29WcE9HU21jU0pSRXNHK1IrZkFULyt2Z2RtajFFOWkz?=
 =?utf-8?B?dWc0VHg0czU5NHB4aEY0YWxrWWhhU21DS0JiQ01Pc3NCR0M5QjdnQTFqb1gy?=
 =?utf-8?B?R1lyRE9BSHlUMlB5TmlzdGF0RXhNWmduaDdRcFpoV3ptWUF5NENpcDJaUHJr?=
 =?utf-8?B?TGg1SzJnaGozZEpBV2pFeUtsNS83V2IwbnVkaWlOVnZ4cFVwK0J1d1p2VGY3?=
 =?utf-8?B?aE42OUptVHpqNUJkU2VBNzZwVzBtQlZJU05ERzV0dVVBdXNPclVaRTJXQzk0?=
 =?utf-8?B?aVM5Vld5QkFFZ3VCV01PemR5VS93eTFHa1dKZTRmN0RqVlg2VjdoQ0ZKMzJP?=
 =?utf-8?B?a0pJeCtCVkVDMldUOW4ycHliSnl4VkxzRG1PdDNJOTc2RDJIQzNGRkF2OERT?=
 =?utf-8?B?akd0WDhveFpWdWt0TEszQ2NWaUdxZFJueWEvOEtobVI3dGhxMDhpYVRKVjZ0?=
 =?utf-8?B?eVdXUTRDYjRpRHp2M2JtcGVOTmdkRG1GS2NKVnpsOVB2MzJwQWRlekFiL2ZC?=
 =?utf-8?B?akdla2IyajFTTmc3eEhkTXZXTDR2ZUJCWXNNbXNoR3htdWdWZWY2bG5mcllv?=
 =?utf-8?B?NllsMU1GaUpPZDhPTGdWLy9CR01vUlh4eTl5VnF1YWsxNENmUGN4U09NTG4x?=
 =?utf-8?B?L3Z1ZnpPYUR6d3p6RjVVNUNtaEVxczZnUnpTSVhRRkxhb0lqa0lWOVFNN28w?=
 =?utf-8?B?SmpjT1p5aUFwcENMQm9GY2xyZVBaVmplRWNWMFk4VmpzOE5saEJTQ3FHM2lm?=
 =?utf-8?B?TFJEclhSWDhOSDlMZlhqUHI3NE9pRUdlbSt6bnlaV1M2a1JhVXg2OWZDa1hU?=
 =?utf-8?B?V2x2Z2h0QVlZQWMzQ1JjT1BkTkpod0ltMjM2RmZlaWlkUDhwSitZaElxTFNS?=
 =?utf-8?B?eGV2b2xDUGJ4VlkwVzIyMmxiUFFVWmRMSHJyQ0RJbTBxbEM1YnYyWkJpenBi?=
 =?utf-8?B?WS9GNzZpRGZHSGNQY01sRER3VG1xRjlkTTFLcGJ0eUMyNHJDMXM2WlorQTBU?=
 =?utf-8?B?Nk1YcXNaUjhMUzh5ZjFaNGo4MGo0b2xnQ2ZyMXgyUTdUM080N1dBV1ZuaUJN?=
 =?utf-8?B?T0dLbVJMWXhnWTVJVkVPZFJiQTdTRDFBUHdBbG5hdllmczhOZG1xSnFlb2ts?=
 =?utf-8?B?a3JhYzNXK0U0OUxnbzhEaFhmS3JPN1d6N1ZUb016NkU3VGxnZW9xcXUyTWpx?=
 =?utf-8?B?ZzJ5OU5ZeWwramdNd1I3TWdVanU2dmlET1pNdVNGUDg1WFRKVU02Z01Zek0z?=
 =?utf-8?B?L0xwbURUUjZjOTBjbTBibWk4ZzRiUG5UM2hPMmFCWDhQMTdsNGJnRjU5YlJk?=
 =?utf-8?B?MElRbllVUzB0dzJPUGxBS3crOWZuVzJOaDNVSGVqSlI4bTdFTS9pUG5McS9R?=
 =?utf-8?B?d2VNZ2p2dTBFT3FEV2ZNVUR3WDVTNzBiRTdVa0YxS2lzWU9EbWhUbkJGQjVa?=
 =?utf-8?B?VmR5ZUtDei9xSlcvYzlhQU1YSitXOE1NSTFuWmgvd2Q0TXZCSmRCbmxIakZG?=
 =?utf-8?B?RXE4YjkxRnRzblRldWdQeSt2RVRzYndZaElQRkE4TVY4NW1LUDN3UnAyNDh6?=
 =?utf-8?B?bXoxbkF6MS8zSlh1YzRIVXRKdVlHa1pxSEtSYlM0cEdaTnJpYWg1R2hzTzFh?=
 =?utf-8?B?ZmFteVU4MVprM1RUbzRGaE9KV3l3UXViUHZGZ2ErNlAwMGM5ZnFIUVBBM01l?=
 =?utf-8?B?OVhhWEpTV1JMNmQwTFpMcmRlY2RyR2RVK09tSGFmSzJ4bDhWNXNqOS8wTmVZ?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F55C52BDB7C17B448C38FF91859E224C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aVcyZW1ONWZ6cVNnbXFZblJLRGF4TWxJeTVQUGdMM0xURlFZb3NlZDBxU2FT?=
 =?utf-8?B?b1hlZnJYQUZmUU0rT1ltZUEwZDlhdEF6SzJoc3ovbUMvNkVPT0ZSZkRlL0ho?=
 =?utf-8?B?Y2lXS2h5ck5KR00zZ1FFVnVzRTltN05KMEdoeGFCTmFJUk9hT0RvT3FDcjdi?=
 =?utf-8?B?N1FwVHN2MGFqYW4xMll0SFNNd1dYa3k1dXc3bjAzTytRbnQ1ZFNvemwya3lS?=
 =?utf-8?B?ZkdYc3B1alIvbEttcnJzbDVCWmd2NTRBQVhJaFhEWDdOb0sraU4rTEFYWkhT?=
 =?utf-8?B?bWZOZWsxM0JBZGJ4Q2tZZE5NWUdMbkZrOHJBQm42Q0p2NDJsdXBDY1gvdUFn?=
 =?utf-8?B?czJmd25zZnFiSGlXREhrU3hnbGFlek94VTdVTkl6NFhOcTgwbnBQMUVoLzA5?=
 =?utf-8?B?clVKejdNTXdjL1BBQjN0SGpJR0g4eHR1dW9ZNU83TGxLc2J4UVFmMVFvRi85?=
 =?utf-8?B?dDVzb1VXRWhldDZSUlhHS0hSMklLa05DRFFlajZ1MDA4ekxYUHZ4NGxsZlpY?=
 =?utf-8?B?TFRLMXc0MlBFSHptVHpTSDhNR0dSRWtHV0pyS2Q5OE1ZWmVVVDlBTGQxYmg4?=
 =?utf-8?B?UkRNWlV3c3h3eVhFaTZwbUN4MVNQV1pVLyt5elhmRmdhWDNZMVhwUmhURHhW?=
 =?utf-8?B?ZWlyREQ0K3BCVUd4T3FKdHc1V240T0p3eGwwUTkyeXNCQ2R5T0dkb1EzbFRr?=
 =?utf-8?B?eWtzMzZ4b3U3ckR0QTJPeVpQNW92T09Xc1hDTHczYmRXcEUzM1ZGc3EvcnQy?=
 =?utf-8?B?YXZuSGlmWHpQaStCUnIxQURrR3FJSjBuZnVzT1YrWEFqa3JWQTZYWlU1M1B3?=
 =?utf-8?B?T3dxSXBYdVhvSTZheEpTenN0NW43SVZDOHRTNnVYRUJWMTRKejdjMWo3bVRk?=
 =?utf-8?B?OVlWTnFwWHMxaHpMT3hDY1VSTTY4ZG8vVXpRcGIvM1hua2FRbDhJSHFzVVd5?=
 =?utf-8?B?V0RYZExBclJCMFNHSWE0SmJxMFplM3lhRmNoa1dURVJpNFRwZzdZcFNsK29W?=
 =?utf-8?B?UFZFbkZ6QzgwcCtKaS9FUEdXUG1aK1lQdjlxaEhmamlOYllvRm5PQ0FNNkhD?=
 =?utf-8?B?RCsyTFJqRG1KUUFxajRpMmhxKzdXaHdvRlhUd3lnd2tlZ05rQ3NRZzhBckRW?=
 =?utf-8?B?Z0w1Uyt4SWRMSG52SHc0cjl1K1Ivam80UkV5UmZ0a0FMVHBIMHJCMllvdklL?=
 =?utf-8?B?WnBsQ1BYdkpsQ1p6UzVqdi9CK3hEUXhWSDAzSTVQaFF2VElaTGkwZnN1VlBn?=
 =?utf-8?B?N0JIbWpUSHBkYUdzWXlxK2t6aCtHNGxLYUtKRjhkdWx2OC8wdz09?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f451f52d-bd99-4869-cd50-08dbd6afb59a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 05:43:55.7351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CgtCaxM1lNucovAw4eqyMwqiY62EMrAXFHOrj7Nk/+KKzc4J3fUYVoDBPCDbKX5fU6YMQ233eCB319Xwey4wmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDI3LzEwLzIwMjMgMDU6NDcsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gT24gMTAv
MjYvMjMgMDY6NDMsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4+IE9uIFRodSwgT2N0IDI2LCAy
MDIzIGF0IDA2OjI4OjM3QU0gLTA3MDAsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4+PiBJZiB0
aGUgcnhlIGRyaXZlciBvbmx5IHN1cHBvcnRzIG1yLnBhZ2Vfc2l6ZSA9PSBQQUdFX1NJWkUsIGRv
ZXMgdGhpcw0KPj4+IG1lYW4gdGhhdCBSWEVfUEFHRV9TSVpFX0NBUCBzaG91bGQgYmUgY2hhbmdl
ZCBmcm9tDQo+Pj4gMHhmZmZmZjAwMCBpbnRvIFBBR0VfU0hJRlQ/DQo+Pg0KPj4gWWVzDQo+IA0K
PiBCb2IsIGRvIHlvdSBwbGFuIHRvIGNvbnZlcnQgdGhlIGFib3ZlIGNoYW5nZSBpbnRvIGEgcGF0
Y2ggb3IgZG8geW91DQo+IHBlcmhhcHMgZXhwZWN0IG1lIHRvIGRvIHRoYXQ/DQoNCkkganVzdCBj
b29rZWQgdGhlIHBhdGNoZXMsIGl0IGNhbiBmaXggU1JQIHByb2JsZW0uIEJ1dCBudm1lIHN0aWxs
IGZhaWxzLg0KDQoNCg0KDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+IEJhcnQuDQo+IA==
