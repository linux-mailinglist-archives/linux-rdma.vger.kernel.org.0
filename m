Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53027850C6
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Aug 2023 08:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjHWGrS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Aug 2023 02:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjHWGrR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Aug 2023 02:47:17 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38355E46;
        Tue, 22 Aug 2023 23:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1692773235; x=1724309235;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=z4VdEDnpJX0heAZRuBMe6zQ7Ipz78/QiGHs5hAM80YY=;
  b=ioyqqSO8BV5nzJf9RGVyWIJreO/YydqEY4/9YKL3PhtRK+sb0G10wXy6
   1u7Ibhs/SwSb3mltD9B/ugXc1gJvfC/Wfr+DmESpwhYT+sSCqEeN+eD1l
   PsTIE69FD3ERe7r3DCa8yvliNY1BlHXPWCkOh1zXUi2EvV9SStGmov3u1
   3ZfDH1KzsWnbuCLdThfCgeJAPYUbm6rnNBXI/2ZK0jVv6MqZhOiS7KPpc
   98c83m/8gANBwzQbiCCc3isa23wdJ2tYDCjJPULvxk//CAbfPn9Bazmyu
   cHbhwUZkgYV90rSGQpkv+cTr95zvrT2O/QnTsJfq2PKQ+FtCyVCSCdjPp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="5954505"
X-IronPort-AV: E=Sophos;i="6.01,195,1684767600"; 
   d="scan'208";a="5954505"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 15:47:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+O47ulNq1S3NMkTtI5sHNQb1xPT/s+XCwLUoh5C9IaxkDMMAIEFQWgcXTO23sSn4WuuHxbFcSTKbq3sm5jfafdyXFR/Yb14/gaLpdjYc0ZYcUQvGBn3z64vy3FsXIiNh0Bi5vHyDL76unMzNEH4mG4pHskvKbb1PBUPSAH8tJZ3cJQpmGy0sm3YGweWZhyPrdfgOYj7OI019Yt7CtMsuxqD3laQ2Q3Olo1oVKc2v3j1mmK9/cB54K+VaA3EIiUx3/+4OAyxLjZI4lXCWVANcz91CWDeXlXJUyfc7YhygLLV9ICorgv3LOsaG4JDwMQwYvjEYnvU5uk91WyEFTukkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4VdEDnpJX0heAZRuBMe6zQ7Ipz78/QiGHs5hAM80YY=;
 b=BSNs3rET6DeCQDfYG27ExFGdsNxPnhfLpovtW9yWovCojeNP5ywWsOlY0AXnDd9Q2ct9+CHwQv3grFcr1kQ43b9Q313+JI2Cbe5ke7KLHjw7eQNmzBjVBHb1598QOpu6KfBiarKlbk3bwdrAG5Ey5wsK+j35i6cZAxvu5pnAKKS2wHqBa2zx8h7kWLIYAO02tNYDtG8RwEzeZDv0pX7gYzvlmi0muavdvWGbJUiRZwLF5Y6Gs9I7oagnORYJRT8gQ4g8DyZ64pzkUpo2b+5cgdEqBzY9sq6l/FzU6H/jw7js6SNfg2/vlp5xFJNV5cjmoRJnrpC5FIAMsI2w6DGIEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OSZPR01MB7820.jpnprd01.prod.outlook.com (2603:1096:604:1b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 06:47:07 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::6996:50d0:fd3d:15f1]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::6996:50d0:fd3d:15f1%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 06:47:07 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "john.ogness@linutronix.de" <john.ogness@linutronix.de>
CC:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: Re: [PATCH 1/2] RDMA/rxe: add missing newline to rxe_set_mtu message
Thread-Topic: [PATCH 1/2] RDMA/rxe: add missing newline to rxe_set_mtu message
Thread-Index: AQHZ1WdeUKk57k5Lwkqt11UK4BLVm6/3ZsIAgAADnwCAAALwgIAAAyMA
Date:   Wed, 23 Aug 2023 06:47:07 +0000
Message-ID: <e823d7aa-99d6-1417-8aca-c89db1c350b9@fujitsu.com>
References: <20230823021306.170901-1-lizhijian@fujitsu.com>
 <ba7f496c-b0af-6532-76c7-08eedea886ce@linux.dev>
 <54f43b58-4986-f2c3-7488-ecaf150b1e79@fujitsu.com>
 <CAD=hENcGfS0++mTTX4z-YT3SAx=5OYyqSf89=AkOCD9+SrUtag@mail.gmail.com>
In-Reply-To: <CAD=hENcGfS0++mTTX4z-YT3SAx=5OYyqSf89=AkOCD9+SrUtag@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OSZPR01MB7820:EE_
x-ms-office365-filtering-correlation-id: ccfe44e2-9a59-4b5c-95e7-08dba3a4c500
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nEXfUN3ow64RgKI68qMJYm62mR6AOZL1/fbIiUlQOUet1t6bb9/GGgcb3FZKWVA4dTep6utP5GmeDLT+ejfhcX2ZEDW6rUYW6tub8eevIyjXKOq1Zeydz5XAWBvk4doV1Co7gXo+/dVWW/Ftx49O+fyRLWXVaZrH2hchlZl7yfn5POUyoHlStLHhmaSwbj5yombE7CXCtduBOewEKO/XNLpWs8smHXZgJwmoLdX7ctnv6L3rtr+vhC5z7iS+fRSD0B3msa90M3ZFZ4kgqHKtmMzENdIizzmmQxyyHJYQtvj7Fccu1qsyGN4UQAZU+thKmF9rZcworC7LozCSQkW3hlSmdJ8Yz4IPrfMnOEXxGbQ+DBtYl3HNlHHAqLUB+w2vIYN3HCSrskcLNxRqxlLsYjjurgHIGz6A0gl7aScewgEXTkuJiZRxVGFaFqclBZDTs5z/Sa8QN5M1sSEBW81jBvnZZ9+4FUPjnPE9U7a948VR87ZjGhL9ZGTsVuwQctO4YZtMDj+Yp7Ac91XG0LjFwe+W09DBhRKX+4bi2mGP/7uVtlSw/oUsba2lvi3Ds5Ptb1nPngBOenRCORErMQs2wuU3yFWDHHX6KL9+GpMs9lo7DKvTLdnsRGXrowfIQ1QQTeDa0aZiWlWF3rd/KVTL28EAnQUHXpHevyQh+P/0jKwSdq1SIn8sG+i5ziQlU5GnSwvTm1tKJPhb2R/OrMawkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11664.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(1590799021)(186009)(1800799009)(451199024)(76116006)(54906003)(66476007)(66556008)(66446008)(64756008)(66946007)(6512007)(316002)(82960400001)(91956017)(110136005)(8676002)(8936002)(2616005)(966005)(4326008)(36756003)(41300700001)(85182001)(478600001)(122000001)(71200400001)(38100700002)(38070700005)(1580799018)(6506007)(15650500001)(6486002)(53546011)(83380400001)(7416002)(2906002)(31686004)(31696002)(86362001)(5660300002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFhSMWtzTGtlVHp1RE5SUUFGK1lTQ01MWW40SEphdEF4QmxZZnRQTERISmdL?=
 =?utf-8?B?bVF4ei8zWFdPNWUzMS90b1U4alYrWStWU0tlbXE3UU10d241L0h0NE9KbWxw?=
 =?utf-8?B?VmpXaEh0bzJhekNmbWQ2cHlNOXZhZElqSXYwdjZLVlJWQ3NaNlIwUER6elpZ?=
 =?utf-8?B?WWpRdEtaRDd3UmNEV0RKcHFld0JzdjN2azVPMll5ZVIyV3F2M2o4TUdhZ08z?=
 =?utf-8?B?aWx0TDNKOU43dVpjNlNrdzhJUVI3V1VPYk9QSkg2QUROTEJOeDVKZThSYkRk?=
 =?utf-8?B?WEtBNFBVc2RnWUpOYVBDY3haZVdIRWJEREttOWxzRnhUUU5LL1BXZUx5ejY4?=
 =?utf-8?B?Tm42Rnp1K1J3cWQremVWYVkwMWRtSTVRNXhaVVgvbkQ2eTcrc0lUMUw2RDJq?=
 =?utf-8?B?a3ZQT3pYVUFPUW1zYXdSZVVVS2QvdmpXWGpRWFk3RkpFdDBMZEY3cVpZTEtu?=
 =?utf-8?B?akQwWUwrZzBuR3YwRVZ1bWxzbEpvNFZ0KzI3Q2NadVJyMExYeTZNZUJvcC9H?=
 =?utf-8?B?Z0w0TlRrQnBYbnVLZ1ByZ3BsM09Wb2hRRXJUbnhIU1BJOEhxQVpabGlaRHdF?=
 =?utf-8?B?TmVCemRXS1ZXV2oweWlDWGFYU2RuMkFZNDBWQ1gxTXVDcjJlaWNEdXlNVVhG?=
 =?utf-8?B?OTVRKzJQRjJtWWVFU2hlZG1KUzNqUWZid2s1U0d6SDFZL3NXeHlDaWRBRGRX?=
 =?utf-8?B?Vnd2T1g3R3RsR2dXK3dsQjlQNjlTTkdOZ3RVd2dORkI2a2U0ZDllMDFZdnE4?=
 =?utf-8?B?M3p1SnEybEZmQUdhd2lvNnRRbVpnSFRpVEdtNDl6akhGUjM4bWtBTzVtKzdx?=
 =?utf-8?B?T0F0alY3aXJYM0V1d0MzaGdYQllWT004VHV6UG1rNWp1QlZaOExDV2pzRDFt?=
 =?utf-8?B?ODl6ZEs0dk1GZVZscjhPcktndlV6Z1I2TTkxVVRxOE1wL21yeEpaYkxZQ3ll?=
 =?utf-8?B?YVYvSm5JN0Frclh3STJQKzRxcjArNFJNSUJ5a0o4TXgyb25VVlpONjg0SG9u?=
 =?utf-8?B?V2JCQ09EVVc3Tkh5enVqVGV2dW5SOTU4bk5jalNvK3Nvdk9NN0IwRGVVVHo5?=
 =?utf-8?B?NlJ5YVAwei9HdDhEMUhZTStaV3ZOSXg2NTZsUUt1MTEwLzkwVEtxOW9sWW1G?=
 =?utf-8?B?YThPV3FRVGpOYjZJNmpycW12ZkE5Um1EWHBBeXM2MkE1Q2o4dEZaS09rZDEx?=
 =?utf-8?B?c1g0K2p4elhrak5wejF5ZHN3cmRpTnRMcjFCSzZWZEpUR1JOOUdPb0grVmhF?=
 =?utf-8?B?bUNZSHRTZzNDeE5LK0kwWldxUTNjbERnNmpHcFRkNlU3K0djM09lM3crYVlJ?=
 =?utf-8?B?TyttR0E3RGNsaWRtN1VVNW8vbXdZOHFaWWpiMDMycDIyVEVlNEQ2SHFpbFFi?=
 =?utf-8?B?RVZkS0h2UmhlWlhrQUNpRy9nVjIzRlhTbTNnc2VlU2cyNjZGZERUNTBZUVcr?=
 =?utf-8?B?dk13anp6RmNORmUxZ2RhZkpiYnQrNUxPY3JMc1VYTHBpOTNSN2R3ZG1ydE1W?=
 =?utf-8?B?UUxGcXdzMWdLNDZCaEVGczlrZDJLZDIvR04yZDhPYVJJSHFjcU5NUzFJVEdn?=
 =?utf-8?B?b20zQVdSQ2lpVjhVc2dTUmFPZEdmem5NdjRzSFcyejV1TU9KQTkwcDd2azlF?=
 =?utf-8?B?d0UvcStQcWd3N21GMWVTVTJUeWtjdldPejlsVm5rVG1Zb2NWZW1MZ2hQVVNW?=
 =?utf-8?B?elJWa0dyNytLc21rY3VldjNsSFl2K1FZY3BmNFRHa0hudVIvKytIYzBwellV?=
 =?utf-8?B?MlM2cEg3V1BzaG9uVWVZcmhDZE5WczJDUVNIZ1pEMm4xQXdQRFlPNFNFTHFv?=
 =?utf-8?B?SVJzNWxWdXMzMzRmWk9abFNBUHllQVExY3J3aFBrR1ZtTjliTEtpdWswNTQx?=
 =?utf-8?B?YWdhMkFjOUVNbjNZVTBQMC9halk0N3JHdUc0VFovRy9iT1hDWXRhQWZRVGtO?=
 =?utf-8?B?RC8wUUhnRlBwb2twOUtwZVBEZElBQittazI1Yyt4Mm9WQStJVmtsNmpWTXh6?=
 =?utf-8?B?bmttS1oxZTBVd2llT0ZaVWxXbGZaZUE4OFg2WHJ1ejZUVCtZcmZwbTlFZ3Nn?=
 =?utf-8?B?QUdIVGtybUFUVU16Z3ZtRHZJL0pFNUhqeUJDZHBla3RuRUZxS1hlbUhEMC9D?=
 =?utf-8?B?d29LRXhmdXh6Mlpnb0VZWVBXUWNoS2o4akxaMm5GMThvSzZWR1p6OFVQazhI?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CDBECC7A2CC2E45AF5E6C45F9A76D49@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aWp6YjZOWjBScEREYUFvdW1MZm9QY0MxOEFiTU9SZXE5Z3Fzbkt5Y0NGNENi?=
 =?utf-8?B?VWRqRFhGUjE4bzFaTEJhU3ZITDFGdFU2RHkyQm5Qam5qa2N0aldiYkxYN0Ni?=
 =?utf-8?B?WjJSQ21yaGNDK2xwQWdRODQ5NHBvTk1MY1g3VG5UbjRTcTZpcm5EVG5PVmh5?=
 =?utf-8?B?VkhiUnNYeVZqRWFUczZLT2hvaTFPNGRwbHRTVHZhZ09xVVIvTC85UURSSUY4?=
 =?utf-8?B?Z3FhWU5DQ0VmQTdWeVN1VmVjcU1TZXkyaGgzL3VWOEpnRHpNdmcxczFlR05V?=
 =?utf-8?B?Z2xmTVc5eHNvelVtczlKMVRaZjZaUElVNktJVmcwMEdLMmp0Qk9FN0ozYzdo?=
 =?utf-8?B?ZVROQUY4S3hOSDd6Z2tmZjBsNWFvYVJQYzluZTFDUysybDV2TFBsTGw0WXZi?=
 =?utf-8?B?Z1gvZStOYlVCRDBrRGtPaEljbHNqdXBHZ3Y1VWdPVFRwc1Y4a1BWRHZmSFNE?=
 =?utf-8?B?WkEyNVFjYTZ6c1FnNHo0UlVEbnJzQVFxeU80VnFNUW5kRnlyclJvN2Z6VUVI?=
 =?utf-8?B?eG5yS3F4SGRPY0tTR0Y2MXFTRGx6WkZDN2ZPaUp2ZGVKbWVKMHNOays2Q3Jz?=
 =?utf-8?B?ajJMMkZPUS9aekZDeTZiUTFaMDdKM3VoTjhJNU5wZVphT2F3THlhRzVGb1Bj?=
 =?utf-8?B?SjVzWENtMHFaU3RpaFdOdUxZM1IzS29ZaVJwQ25Rc1VFNUpoVXBHU1FvYWJO?=
 =?utf-8?B?b2pFKzMwV2NYaUYyZktRbWJILzhsbkRBMjdaTVdFMXU1ZUxiazBpZXlxenFs?=
 =?utf-8?B?OGRjanQ2Y0hwdlFZNmhhMGQ2M2dRTTdLS1pjcm9GdnEyVzNvelhoT3grd0xH?=
 =?utf-8?B?SkZKSi9peGFwM3RncWU5SkFvTHNLclhzaDcyTTFkS3dNNWw1blV1UEhaV096?=
 =?utf-8?B?bWV4Y3Y3d3JMVGtySnVYSk1BWWo4dmpIMGNFQk53Q0VSRDBVRHNqSExrYzk5?=
 =?utf-8?B?c09EOXpWQTN6dnZHLzRqYU95VTMxRWVHZkNBbkRQeHRsY1ErcElSL01MVEN5?=
 =?utf-8?B?emFEdk5sWmFBQ3hjSUlHWGxhb1VQV3BneTl1ZEJZNjU1Wm9nUFg3QVc3TUJp?=
 =?utf-8?B?elhWUDBicDllWVYvZVIxVkY0S2ovYmN4UW9PV0tmTXRkMS9RMStsNG50UkZS?=
 =?utf-8?B?RnhkL1J2ckJFdWZqa2daaEJjWFp5L2lpQjZkdEt2UlFoT0lCR1poV25zSDZO?=
 =?utf-8?B?TEVmbW5DWmMwSzhEUlo5a05haGVNaHZiY1RMejNvbkZReW50RXhzdjFFRTZ0?=
 =?utf-8?B?cXNNTzNwTzVNUXYyVzI5VTR6bmU0L1FLazZBbTRocXVleVNMYlJYdXZvSjdL?=
 =?utf-8?Q?zzwbSjWgtGcDjTcFfmYjdaK5XnOU+TkcFb?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfe44e2-9a59-4b5c-95e7-08dba3a4c500
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 06:47:07.7798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u8pzLf7vcY9khfJQ3B7UxDtjO6NNHldq4GZp3xnJSmubJKrf59Pk4sI1Ymm5SuXzSJQ6unA5oGiERWBQzZOtCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7820
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDIzLzA4LzIwMjMgMTQ6MzUsIFpodSBZYW5qdW4gd3JvdGU6DQo+IE9uIFdlZCwgQXVn
IDIzLCAyMDIzIGF0IDI6MjXigK9QTSBaaGlqaWFuIExpIChGdWppdHN1KQ0KPiA8bGl6aGlqaWFu
QGZ1aml0c3UuY29tPiB3cm90ZToNCj4+DQo+Pg0KPj4NCj4+IE9uIDIzLzA4LzIwMjMgMTQ6MTIs
IFpodSBZYW5qdW4gd3JvdGU6DQo+Pj4g5ZyoIDIwMjMvOC8yMyAxMDoxMywgTGkgWmhpamlhbiDl
hpnpgZM6DQo+Pj4+IEEgbmV3bGluZSBoZWxwIGZsdXNoaW5nIG1lc3NhZ2Ugb3V0Lg0KPj4+DQo+
Pj4gcnhlX2luZm9fZGV2IHdpbGwgZmluYWxseSBjYWxsIHByaW50ayB0byBvdXRwdXQgaW5mb3Jt
YXRpb24uDQo+Pj4NCj4+PiBJbiB0aGlzIGxpbmsgaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRz
L2xpbnV4L2Jsb2IvbWFzdGVyL0RvY3VtZW50YXRpb24vY29yZS1hcGkvcHJpbnRrLWJhc2ljcy5y
c3QsDQo+Pj4gIg0KPj4+IEFsbCBwcmludGsoKSBtZXNzYWdlcyBhcmUgcHJpbnRlZCB0byB0aGUg
a2VybmVsIGxvZyBidWZmZXIsIHdoaWNoIGlzIGEgcmluZyBidWZmZXIgZXhwb3J0ZWQgdG8gdXNl
cnNwYWNlIHRocm91Z2ggL2Rldi9rbXNnLiBUaGUgdXN1YWwgd2F5IHRvIHJlYWQgaXQgaXMgdXNp
bmcgZG1lc2cuDQo+Pj4gIg0KPj4+IERvIHlvdSBtZWFuIHRoYXQgYSBuZXcgbGluZSB3aWxsIGhl
bHAgdGhlIGtlcm5lbCBsb2cgYnVmZmVyIGZsdXNoIG1lc3NhZ2Ugb3V0Pw0KPj4NCj4+IFllYWgs
IHRoZSBtZXNzYWdlIHdpbGwgYmUgYnVmZmVyZWQgdW50aWwgaXQgaXMgZnVsbCBvciBpdCBtZWV0
cyBhIG5ld2xpbmUuDQo+IA0KPiBBZGQgUFJJTlRLIHJldmlld2VyczoNCj4gDQo+IFBldHIgTWxh
ZGVrIDxwbWxhZGVrQHN1c2UuY29tPg0KPiBTZXJnZXkgU2Vub3poYXRza3kgPHNlbm96aGF0c2t5
QGNocm9taXVtLm9yZz4NCj4gU3RldmVuIFJvc3RlZHQgPHJvc3RlZHRAZ29vZG1pcy5vcmc+DQo+
ICAgSm9obiBPZ25lc3MgPGpvaG4ub2duZXNzQGxpbnV0cm9uaXguZGU+DQo+IA0KPiBUaGlzIGlz
IGFib3V0IHByaW50ay4gVGhleSBjYW4gZGVjaWRlIHRoaXMgY29tbWl0Lg0KDQpJIGRvbid0IHRo
aW5rIGl0J3MgYSBwcmludGsgc3R1ZmYuDQoNCkluIGdlbmVyYWwsIHdoZW4gZGV2ZWxvcGVycyBh
ZGQgc29tZSBwcmludGsoKS9wcl9pbmZvKCkgdG8gcHJpbnQgc29tZSBtZXNzYWdlIGluIHRoZSBr
ZXJuZWwsIHRoZXkgZXhwZWN0IHRoaXMgbWVzc2FnZSB3aWxsIGJlIHByaW50ZWQgaW4gdGltZS4N
ClNvIG1vc3Qgb2YgdGhlIHByaW50aygpL3ByX2luZm8oKSBjYWxscyBpbiBjdXJyZW50IGtlcm5l
bCBhY2NvbXBhbnkgYSAnXG4nIGF0IHRoZSBlbmQuDQoNCkFuZCBwcmludGsoKSB3aWxsIGFsc28g
cHJpbnQgbWVzc2FnZSB0byAnY29uc29sZScgYnkgZGVmYXVsdCwgY29uc29sZSBjb3VsZCBiZSBh
IHNlcmlhbCBwb3J0KHR0eVMwKSBvciB0dHkxIGV0Yy4NCg0KVGhhbmtzDQpaaGlqaWFuDQoNCg0K
PiANCj4gWmh1IFlhbmp1bg0KPiANCj4+DQo+Pg0KPj4NCj4+Pg0KPj4+IFpodSBZYW5qdW4NCj4+
Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29t
Pg0KPj4+PiAtLS0NCj4+Pj4gICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGUuYyB8IDIg
Ky0NCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZS5j
IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGUuYw0KPj4+PiBpbmRleCA1NGM3MjNhNmVk
ZGEuLmNiMmMwZDU0YWFlMSAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3
L3J4ZS9yeGUuYw0KPj4+PiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZS5jDQo+
Pj4+IEBAIC0xNjEsNyArMTYxLDcgQEAgdm9pZCByeGVfc2V0X210dShzdHJ1Y3QgcnhlX2RldiAq
cnhlLCB1bnNpZ25lZCBpbnQgbmRldl9tdHUpDQo+Pj4+ICAgICAgICBwb3J0LT5hdHRyLmFjdGl2
ZV9tdHUgPSBtdHU7DQo+Pj4+ICAgICAgICBwb3J0LT5tdHVfY2FwID0gaWJfbXR1X2VudW1fdG9f
aW50KG10dSk7DQo+Pj4+IC0gICAgcnhlX2luZm9fZGV2KHJ4ZSwgIlNldCBtdHUgdG8gJWQiLCBw
b3J0LT5tdHVfY2FwKTsNCj4+Pj4gKyAgICByeGVfaW5mb19kZXYocnhlLCAiU2V0IG10dSB0byAl
ZFxuIiwgcG9ydC0+bXR1X2NhcCk7DQo+Pj4+ICAgIH0NCj4+Pj4gICAgLyogY2FsbGVkIGJ5IGlm
YyBsYXllciB0byBjcmVhdGUgbmV3IHJ4ZSBkZXZpY2UuDQo+Pj4=
