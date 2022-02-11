Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BC24B26F4
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Feb 2022 14:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350505AbiBKNTB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Feb 2022 08:19:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350504AbiBKNTB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Feb 2022 08:19:01 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2291A9
        for <linux-rdma@vger.kernel.org>; Fri, 11 Feb 2022 05:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644585539; x=1676121539;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=0wX9dd0dW5+eoZTN9hRXr7fEO+bdgwM3L2wnpv0c0Z8=;
  b=ACyYFXfnH0rnMlN9+BkLijHTER26SRIv9CgEiSnhC6ZicvvVZ+MxxvRV
   hJzwZOMlnyy7aJYynidcWcEPwc3q8eGyvjDoxQFD7jEQv+d52u7yYmaqA
   rkg+9UiksGQXaBDmcHk8nxyyrG/yq3yORZi38dUUFbuYqD5FV19iFWuqi
   rAc4jFxXUquFjVyhBpXjxt3jgV1UpuFvBJz42vFW4hJY9qnzObUbB6cyQ
   DJAMssYD+Joyrd8ZtHbO0/hr+TMWsAcsj3W6Sjqbv0Qg99gWVlzukC7Q+
   2xoO8S5CsFrtAuS37AflnAat3WtpS/bCvIcuFPykNY17haTJrwEwAuuZp
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="336152173"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="336152173"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 05:18:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="487726951"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 11 Feb 2022 05:18:54 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 11 Feb 2022 05:18:54 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 11 Feb 2022 05:18:53 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 11 Feb 2022 05:18:53 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 11 Feb 2022 05:18:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYQ4cj8EYw5Z98KLR5qkPbyRiJWF6L3xKrZIKYuVUmNQSfNmpsm6a6tOX74+RMctfG90pboQhDUjxJRb1Ht5+Vh1qc94MtVwGiZDZzWLEaP84TfP9tEfvC/L7bJnvHP07LoZaWT7RnRDS1+n53QBEvnub0fG2RLMgkxEOLdhNpWqEFhf1jeGodKMFifYxoLpBzPuRux8K9s/B6IPBH/uaif9cLVt1T2yqwqHMiaw8+NO7ovN36Za5+iXEe6bOUTc0xjqEaE7XNg5romKybkTCFLSDf0nFrl77mhdXXCWJM5/+nOqckkhqXMOyjBGionxK+oaCRbuFzs9KXxu4xo2XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8i9X7UAzWalfbcXRBiyZL+naFFiIHPsA8LLtli1WR0=;
 b=YTxyuqGlFyJLP4iXe4Zwo/BKHJHxzgVD+qwC4Y3K4iK1R3yLcNUHW8xKOUyGnMIbFqwxW6mTL9ijw5r0WE/IwtI1zgQQNWzdOy0jqu84fVk780QQQ1YfR5V6zMZ2uySSR3VMoSy3Ahr7Tz5m57Wt80pwu/w9DmofFfQKrnhDwEVXv3ljwk8umWvXmjskNE7HLdy1+zWOj7mBrB+Ncfp1eSAFmHsspZXrobDUJ5E2qMOqWSpntCCETON3A5HrqbI2GUzyKRWlUMzma4/deNXkPexE88P4inXQb+4XvgQdhFqMgqv2+c4PJEof5HpzzzP8FvZ1MI/gxLWMgJhn4DBzWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BN6PR11MB0017.namprd11.prod.outlook.com (2603:10b6:405:6c::34)
 by BN6PR11MB1315.namprd11.prod.outlook.com (2603:10b6:404:49::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 13:18:52 +0000
Received: from BN6PR11MB0017.namprd11.prod.outlook.com
 ([fe80::e46b:b0e5:c630:6e3a]) by BN6PR11MB0017.namprd11.prod.outlook.com
 ([fe80::e46b:b0e5:c630:6e3a%5]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 13:18:52 +0000
From:   "Gromadzki, Tomasz" <tomasz.gromadzki@intel.com>
To:     Tom Talpey <tom@talpey.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: RE: [RFC PATCH 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Topic: [RFC PATCH 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Index: AQHX/XbzX1EESQbPR0e1EYeMIahx7KxLZgLAgAArYQCAAJOWAIAGetqAgABhgQCAO5P84A==
Date:   Fri, 11 Feb 2022 13:18:51 +0000
Message-ID: <BN6PR11MB00176101EFC53B537C6F746895309@BN6PR11MB0017.namprd11.prod.outlook.com>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
 <BN6PR11MB0017C42F7DE2A193E547AC2695459@BN6PR11MB0017.namprd11.prod.outlook.com>
 <28b36be8-e618-9f4c-93f7-e35b915d17a6@talpey.com>
 <61CEA398.7090703@fujitsu.com> <61D4131D.5070700@fujitsu.com>
 <8c772721-2023-c9e4-ff28-151411253a7c@talpey.com>
In-Reply-To: <8c772721-2023-c9e4-ff28-151411253a7c@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9a64a3e-11ef-476b-5e55-08d9ed610c1e
x-ms-traffictypediagnostic: BN6PR11MB1315:EE_
x-microsoft-antispam-prvs: <BN6PR11MB1315516ACCF47C71D591FD8D95309@BN6PR11MB1315.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4G5oUir2TJsLwMFMu3kche1sI6uUr/sNo7moxc7XxieAstO2s5yF4+5H6LmuhuqKrMeIGwl0Tzw6nE0jkLRw4HzUyaVENt9Ovh2SVzsmzqTdBL9QQdi8cFyhp+IupRHn6cZS6MsLCS/JuQfCPp0tjwoK6a/lcDicalk4zIsmu0ZWYBEuaK/iojRJ6YECK967xbXRx02mnsMZAIuIEf0EaPQRISCmXok/JnntmS+TYkLn486tDQwDA6vqbZ+ymxZJX2617c0zmaDiG075IOtG8Sl0bjgh+FkfUlRYK+82tInS4nPbmm0nEediHvCXa5dPYL9S6YWEQfQrNjhCXI7qcRgOhNmA0T4UbNpL+yFD6Eoe6g08OCmEeJdsCAVrYVlawL9oifkWzPScTgcDS23kNPhFlot+m0ACZNfC0/moQVgDJ42wGFWotkSh9CplGu/SV44i1HA+SbPTiYhfVMIVBC3BkpsNWNLw14ttizlHcBP15wHef+ZQJ57pmXbv9k8uLZOausSMMV7o+0A/BbDERZJS+qdakgvTq95p1kYoxtt/wQuJaKW3FR6o2aGPy2sjX17qPQLG9IrUr6V5qU2VdTcTZNGq5yETn1waryfa0fmWps66Q1nmNR0s/kHQkRJ+f5fxkQKHJE7fwbThfATNq4eZCMnxh9E3XUyB/65hMxrGux0mcTZx1Yhxhc70UoUG8K78MJbD1mpHm86wQ7gxiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB0017.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(54906003)(82960400001)(2906002)(186003)(26005)(86362001)(71200400001)(316002)(83380400001)(110136005)(53546011)(5660300002)(7696005)(8936002)(52536014)(55016003)(38100700002)(76116006)(66946007)(66556008)(66476007)(66446008)(8676002)(4326008)(64756008)(9686003)(38070700005)(33656002)(122000001)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUJqem43aXJ5TllsZGFyWUdQZXhERklXd2lPNlJ3Z1BlTlhuQzllYjJGVXE2?=
 =?utf-8?B?cUJIb0hCdDRrOFY2bE42dUg4ZEFZVWRRMU9wUG9mOEgvanliNHRQNlBadTVZ?=
 =?utf-8?B?ZGQwM1JaemFhQmxnWmJkQTNaN28zK1NNMkgyZ1g2OGJmMGoyU0VBazh0WlB5?=
 =?utf-8?B?VHdCTUkwV0t1UDZ1Zzh6MWNKRUdSQXJjL0k3dGlGbXRiSG5YRlE0UUZuY0pW?=
 =?utf-8?B?VmhjNXNDZ1JBTWZkcTZYazdoRFZnWk02OXd0ZFVtVkhWRGEvWnVNNG5TQWNr?=
 =?utf-8?B?ZHFBNVVqNHcrdE1HWUxqenFtQnRianJZWXVxdWhIWUd6NVFKaURYa3dKMy9T?=
 =?utf-8?B?aDFISHhEVzJHMG1NVkR0MVJhNnJkRm9VMVpjZXVTc1dCaG5SWVpSclFzMjdI?=
 =?utf-8?B?U2FEN2pSWGdvWUQ0MER0U2RRTFB4TGxVbGRIQWRIcm92ajhzZG02eDc3MVJu?=
 =?utf-8?B?ZWlaMHlneWVidmp4YmRJWGxIYXg4aGlMM2ttVklxR0hxTXI5RnZpc2JxVFp1?=
 =?utf-8?B?UzJtYjhwZFI1R21uQVZLQXpZY3UyQWx6MEsxekpOT3dFRXRZUjc4UDZOcmZG?=
 =?utf-8?B?alpsZkZ4OTZaT21wUTZPRDU1Yk1QVXFHUlVzaVZ2cjhXV1pwMTZJMjRYQ3cy?=
 =?utf-8?B?a2NVTnZEdklkUGU2V284YTlDVlhSTWF5aHNHbVg1dVFhT29KQ3lGZ2NNSFdG?=
 =?utf-8?B?QWF0Nm9RbHVGN01KRWQ5ckJYdkpzOExXdG0vNCtIUzhmaTZ5dW1aMWJ5cW8v?=
 =?utf-8?B?eFl1UnlHU0U2djA3YndrOUxtYm1nLzZ4dHEyV1JxMUNUN0thSkZjb0NiY2h0?=
 =?utf-8?B?UUtjMitHZFJ6WHVGWGJyaXdRVGdvRGdNNW04WU8wK0tBeHlQQW42T0lGVFZl?=
 =?utf-8?B?U1RhMzhxZXRGQm9EZUhXTFR6c3cxY2dXK24xRjk1d05TdDhtTlhVNHh3bGYw?=
 =?utf-8?B?ell2WTZWN25LaEw1SS93TXFNYWplMUdHdE9EdE43WE0vbjc3WGhacXRQUEp0?=
 =?utf-8?B?Uy9QOCtOOGJ2dTBQRmJkV3lnWldiQi9JUTc2eWlVQ0JCT09ob2ZWR2w4NWJz?=
 =?utf-8?B?dEJYZGhFTXRBV0VDWlFFbjdONWRPOUlYTU4xMTA4UE1JVTArSjBFZ3Byc0RW?=
 =?utf-8?B?Slp2NjVHSlZkbGo4dkJBdzdFRHI1dStrTFZVT3ZPMVpqNi92WU9iMTRhSDJP?=
 =?utf-8?B?OWZpV0grNWZjcTFlUW5wRGZGOWxUVmNJeDVEQ3dZeE1vRVBXMkVwUEVDT0Fs?=
 =?utf-8?B?M1ZlREVTVDBkK2piNTRoeFF4MjJ6bnJyRGxIbjZWUW9YNDhxbjYxRjdCNklN?=
 =?utf-8?B?OWErRnY3eHFNT0RhVC93STRpYVJMTU0vRitrRmN6MHgzdFVvenQ0NC9IV0ho?=
 =?utf-8?B?STA0ck9zNGxRaXVpbVBCaW1aOUFtdDhZT1RoOE9CNUJBaXc3U1NhcER5bG1G?=
 =?utf-8?B?d0VMd3U4RXJtTStyRzlkN1pKNjFOYXdIOFNrQTgwSG1TZGpYRjEwUmdYSVlP?=
 =?utf-8?B?aVpQeG9sWEQ3dElqMWtTd3g2MThqYnM2akI5WTZLMjNsSmRCVkh0RTRJTDhC?=
 =?utf-8?B?a0Q0Vm5hQVlaenExVGg0NldBNXdQbWZobXdZNVdaQUxsc0FZdCs2Q3dwT3FF?=
 =?utf-8?B?Yk04WXY5RVV3OWtuQ2RxcGlWZWFXdG1vbFk4ZHRhN0FqTDhyd3c4NTk1N2hN?=
 =?utf-8?B?TG9ZQTRxbjVlVnZaeHJxNCtGUGFKK1RqZE9hdlo5MjY4RlZuK1NGdzNIcUMy?=
 =?utf-8?B?UXkrcHN5WUtCMWNWbURYZ05BYU9ZdGZmYkZLcEZ4TEhITjBlZnpTZW1lTHB5?=
 =?utf-8?B?MW9wRHBFWXNzN0p0L053b0kxMm5MRFZrUmFBRUx3K3dBaDF5UzR2VUZwcEdB?=
 =?utf-8?B?NFUvaHVpUDIzQUhPWnhmMUVIL1gxQWhFMWcyazQyNFNmRXhHbjBQYUk3b1BK?=
 =?utf-8?B?Q25mRE5NNFUzZHJOZWxydUNYcnVlNVFTeXdmVW1jS1NsMHVCYVd4NGZNMnNi?=
 =?utf-8?B?aVFNMERFYXdGaUV6NzhQZkFsYXhibndHMmk3N0cwdW1tQ216bGt2cE1MUFhm?=
 =?utf-8?B?QUFZcEZ2NzVldTlUQkcrRWRkRGdZTU8xWVhLcDhyUmtxOHplWU1LaUNDMGhu?=
 =?utf-8?B?eGhqRjRSdXhlZUhYUS9qQ0t0TlF2MnZzVmxMaUhBVUdxblB3Q2ZXWlhhTDVt?=
 =?utf-8?B?OHhjaHZ5NFpoWXNYRTR1NzJkRWQzTlI4QnZzZy80cTRYMjhYd3RpWUJLcGRy?=
 =?utf-8?B?aXhIVlFYKzVpSHFPb2xzcEY1aDZBPT0=?=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB0017.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a64a3e-11ef-476b-5e55-08d9ed610c1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 13:18:51.9469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Iykhg/Xpcs2Drk7tJIUn2HDSapk0oSe8cgxEnVrCI0QNzAYhoDvdgGWeAaagIUAc9ARL2EIwiBmhZjgWuDFl69xMjL9FazOcZwOa0EWDrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1315
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGkNCg0KSSBoYXZlIG9uZSBxdWVzdGlvbiByZWxhdGVkIHRvIGF0b21pYyB3cml0ZSBBUEkgYW5k
IGlidl93ciBleHRlbnNpb246DQoNCj4gPiB2b2lkICgqd3JfcmRtYV9hdG9taWNfd3JpdGUpKHN0
cnVjdCBpYnZfcXBfZXggKnFwLCB1aW50MzJfdCBya2V5LA0KPiA+CQkJICAgICB1aW50NjRfdCBy
ZW1vdGVfYWRkciwgdWludDY0X3QgYXRvbWljX3dyKTsNCg0KPiA+IHN0cnVjdCB7DQo+ID4gICAg
ICAgdWludDY0X3QgICAgcmVtb3RlX2FkZHI7DQo+ID4gICAgICAgdWludDMyX3QgICAgcmtleTsN
Cj4gPiAgICAgICB1aW50NjRfdCAgICB3cl92YWx1ZToNCj4gPiB9IHJkbWE7DQoNCg0KSW4gYm90
aCBwbGFjZXMsIGF0b21pYyB2YWx1ZSBpcyBkZWZpbmVkIGFzIHVpbnQ2NCBidXQgdGhlIElCVEEg
c3BlYyBkZWZpbmVzIGl0IGFzIDggYnl0ZXMgYXJyYXkuDQoNCiJUaGUgbWVzc2FnZSBzaXplIG11
c3QgYmUgOCBieXRlcyBhbmQgaXMgd3JpdHRlbiB0byBhIGNvbnRpZ3VvdXMgcmFuZ2Ugb2YgdGhl
IGRlc3RpbmF0aW9uIFFQJ3MgdmlydHVhbCBhZGRyZXNzIHNwYWNlIg0KDQpXb3VsZCBpdCBiZSBi
ZXR0ZXIgdG8gaGF2ZSANCnVpbnQ4X3QgYXRvbWljX3dyIGluIHdyX3JkbWFfYXRvbWljX3dyaXRl
KC4uLikgZGVjbGFyYXRpb24NCg0KYW5kIA0KDQp1aW50OF90IHdyX3ZhbHVlWzhdIGluIHN0cnVj
dCB7IC4uLiB9IHJkbWE/DQoNCkkgaGF2ZSBjaGVja2VkIENtcFN3YXAgYW5kIEZldGNoQWRkIGFu
ZCBpbiB0aGVzZSBjYXNlcywgSUJUQSBTcGVjIHNheXMgZXhwbGljaXRseSBhYm91dCA2NCBiaXRz
IHZhbHVlcy4NCg0KUmVnYXJkcw0KVG9tYXN6DQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBUb20gVGFscGV5IDx0b21AdGFscGV5LmNvbT4NCj4gU2VudDogVHVlc2Rh
eSwgSmFudWFyeSA0LCAyMDIyIDQ6MTcgUE0NCj4gVG86IHlhbmd4Lmp5QGZ1aml0c3UuY29tOyBH
cm9tYWR6a2ksIFRvbWFzeg0KPiA8dG9tYXN6Lmdyb21hZHpraUBpbnRlbC5jb20+DQo+IENjOiBs
aW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsgeWFuanVuLnpodUBsaW51eC5kZXY7DQo+IHJwZWFy
c29uaHBlQGdtYWlsLmNvbTsgamdnQG52aWRpYS5jb207IHktZ290b0BmdWppdHN1LmNvbTsNCj4g
bGl6aGlqaWFuQGZ1aml0c3UuY29tDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDAvMl0gUkRN
QS9yeGU6IEFkZCBSRE1BIEF0b21pYyBXcml0ZSBvcGVyYXRpb24NCj4gDQo+IA0KPiBPbiAxLzQv
MjAyMiA0OjI4IEFNLCB5YW5neC5qeUBmdWppdHN1LmNvbSB3cm90ZToNCj4gPiBPbiAyMDIxLzEy
LzMxIDE0OjMwLCB5YW5neC5qeUBmdWppdHN1LmNvbSB3cm90ZToNCj4gPj4gT24gMjAyMS8xMi8z
MSA1OjQyLCBUb20gVGFscGV5IHdyb3RlOg0KPiA+Pj4gT24gMTIvMzAvMjAyMSAyOjIxIFBNLCBH
cm9tYWR6a2ksIFRvbWFzeiB3cm90ZToNCj4gPj4+PiAxKQ0KPiA+Pj4+PiByZG1hX3Bvc3RfYXRv
bWljX3dyaXRldihzdHJ1Y3QgcmRtYV9jbV9pZCAqaWQsIHZvaWQgKmNvbnRleHQsDQo+ID4+Pj4+
IHN0cnVjdCBpYnZfc2dlICpzZ2wsDQo+ID4+Pj4+ICAgICAgICAgICAgICAgaW50IG5zZ2UsIGlu
dCBmbGFncywgdWludDY0X3QgcmVtb3RlX2FkZHIsIHVpbnQzMl90DQo+ID4+Pj4+IHJrZXkpDQo+
ID4+Pj4gRG8gd2UgbmVlZCB0aGlzIEFQSSBhdCBhbGw/DQo+ID4+Pj4gT3RoZXIgYXRvbWljIG9w
ZXJhdGlvbnMgKGNvbXBhcmVfc3dhcC9hZGQpIGRvIG5vdCB1c2Ugc3RydWN0DQo+ID4+Pj4gaWJ2
X3NnZSBhdCBhbGwgYnV0IGhhdmUgYSBkZWRpY2F0ZWQgcGxhY2UgaW4gc3RydWN0IGliX3NlbmRf
d3Igew0KPiA+Pj4+IC4uLg0KPiA+Pj4+ICAgICAgICAgICBzdHJ1Y3Qgew0KPiA+Pj4+ICAgICAg
ICAgICAgICAgdWludDY0X3QgICAgcmVtb3RlX2FkZHI7DQo+ID4+Pj4gICAgICAgICAgICAgICB1
aW50NjRfdCAgICBjb21wYXJlX2FkZDsNCj4gPj4+PiAgICAgICAgICAgICAgIHVpbnQ2NF90ICAg
IHN3YXA7DQo+ID4+Pj4gICAgICAgICAgICAgICB1aW50MzJfdCAgICBya2V5Ow0KPiA+Pj4+ICAg
ICAgICAgICB9IGF0b21pYzsNCj4gPj4+PiAuLi4NCj4gPj4+PiB9DQo+ID4+Pj4NCj4gPj4+PiBX
b3VsZCBpdCBiZSBiZXR0ZXIgdG8gcmV1c2UgKGV4dGVuZCkgYW55IGV4aXN0aW5nIGZpZWxkPw0K
PiA+Pj4+IGkuZS4NCj4gPj4+PiAgICAgICAgICAgc3RydWN0IHsNCj4gPj4+PiAgICAgICAgICAg
ICAgIHVpbnQ2NF90ICAgIHJlbW90ZV9hZGRyOw0KPiA+Pj4+ICAgICAgICAgICAgICAgdWludDY0
X3QgICAgY29tcGFyZV9hZGQ7DQo+ID4+Pj4gICAgICAgICAgICAgICB1aW50NjRfdCAgICBzd2Fw
X3dyaXRlOw0KPiA+Pj4+ICAgICAgICAgICAgICAgdWludDMyX3QgICAgcmtleTsNCj4gPj4+PiAg
ICAgICAgICAgfSBhdG9taWM7DQo+ID4+PiBBZ3JlZWQuIFBhc3NpbmcgdGhlIGRhdGEgdG8gYmUg
d3JpdHRlbiBhcyBhbiBTR0UgaXMgdW5uYXR1cmFsIHNpbmNlDQo+ID4+PiBpdCBpcyBhbHdheXMg
ZXhhY3RseSA2NCBiaXRzLiBUd2Vha2luZyB0aGUgZXhpc3RpbmcgYXRvbWljIHBhcmFtZXRlcg0K
PiA+Pj4gYmxvY2sgYXMgVG9tYXN6IHN1Z2dlc3RzIGlzIHRoZSBiZXN0IGFwcHJvYWNoLg0KPiA+
PiBIaSBUb21hc3osIFRvbQ0KPiA+Pg0KPiA+PiBUaGFua3MgZm9yIHlvdXIgcXVpY2sgcmVwbHku
DQo+ID4+DQo+ID4+IElmIHdlIHdhbnQgdG8gcGFzcyB0aGUgOC1ieXRlIHZhbHVlIGJ5IHR3ZWFr
aW5nIHN0cnVjdCBhdG9taWMgb24gdXNlcg0KPiA+PiBzcGFjZSwgd2h5IGRvbid0IHdlIHRyYW5m
ZXIgdGhlIDgtYnl0ZSB2YWx1ZSBieSBBVE9NSUMgRXh0ZW5kZWQNCj4gPj4gVHJhbnNwb3J0IEhl
YWRlciAoQXRvbWljRVRIKSBvbiBrZXJuZWwgc3BhY2U/DQo+ID4+IFBTOiBJQlRBIGRlZmluZXMg
dGhhdCB0aGUgOC1ieXRlIHZhbHVlIGlzIHRyYW5mZXJlZCBieSBSRE1BIEV4dGVuZGVkDQo+ID4+
IFRyYW5zcG9ydCBIZWFkZShSRVRIKSArIHBheWxvYWQuDQo+ID4+DQo+ID4+IElzIGl0IGluY29u
c2lzdGVudCB0byB1c2Ugc3RydWN0IGF0b21pYyBvbiB1c2VyIHNwYWNlIGFuZCBSRVRIICsNCj4g
Pj4gcGF5bG9hZCBvbiBrZXJuZWwgc3BhY2U/DQo+ID4gSGkgVG9tYXN6LCBUb20NCj4gPg0KPiA+
IEkgdGhpbmsgdGhlIGZvbGxvd2luZyBydWxlcyBhcmUgcmlnaHQ6DQo+ID4gUkRNQSBSRUFEL1dS
SVRFIHNob3VsZCB1c2Ugc3RydWN0IHJkbWEgaW4gbGlidmVyYnMgYW5kIFJFVEggKyBwYXlsb2Fk
DQo+ID4gaW4ga2VybmVsLg0KPiA+IFJETUEgQXRvbWljIHNob3VsZCB1c2Ugc3RydWN0IGF0b21p
YyBpbiBsaWJ2ZXJicyBhbmQgQXRvbWljRVRIIGluIGtlcm5lbC4NCj4gPg0KPiA+IEFjY29yZGlu
ZyB0byBJQlRBJ3MgZGVmaW5pdGlvbiwgUkRNQSBBdG9taWMgV3JpdGUgc2hvdWxkIHVzZSBzdHJ1
Y3QNCj4gPiByZG1hIGluIGxpYmlidmVyYnMuDQo+IA0KPiBJIGRvbid0IHF1aXRlIHVuZGVyc3Rh
bmQgdGhpcyBzdGF0ZW1lbnQsIHRoZSBJQlRBIGRlZmluZXMgdGhlIHByb3RvY29sIGJ1dA0KPiBk
b2VzIG5vdCBkZWZpbmUgdGhlIEFQSSBhdCBzdWNoIGEgbGV2ZWwuDQo+IA0KPiBJIGRvIGhvd2V2
ZXIgYWdyZWUgd2l0aCB0aGlzOg0KPiANCj4gPiBIb3cgYWJvdXQgYWRkaW5nIGEgbWVtYmVyIGlu
IHN0cnVjdCByZG1hPyBmb3IgZXhhbXBsZToNCj4gPiBzdHJ1Y3Qgew0KPiA+ICAgICAgIHVpbnQ2
NF90ICAgIHJlbW90ZV9hZGRyOw0KPiA+ICAgICAgIHVpbnQzMl90ICAgIHJrZXk7DQo+ID4gICAg
ICAgdWludDY0X3QgICAgd3JfdmFsdWU6DQo+ID4gfSByZG1hOw0KPiANCj4gWWVzLCB0aGF0J3Mg
d2hhdCBUb21hc3ogYW5kIEkgd2VyZSBzdWdnZXN0aW5nIC0gYSBuZXcgdGVtcGxhdGUgZm9yIHRo
ZQ0KPiBBVE9NSUNfV1JJVEUgcmVxdWVzdCBwYXlsb2FkLiBUaGUgdGhyZWUgZmllbGRzIGFyZSB0
byBiZSBzdXBwbGllZCBieSB0aGUNCj4gdmVyYiBjb25zdW1lciB3aGVuIHBvc3RpbmcgdGhlIHdv
cmsgcmVxdWVzdC4NCj4gDQo+IFRvbS4NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpJbnRlbCBUZWNobm9sb2d5IFBv
bGFuZCBzcC4geiBvLm8uCnVsLiBTbG93YWNraWVnbyAxNzMgfCA4MC0yOTggR2RhbnNrIHwgU2Fk
IFJlam9ub3d5IEdkYW5zayBQb2xub2MgfCBWSUkgV3lkemlhbCBHb3Nwb2RhcmN6eSBLcmFqb3dl
Z28gUmVqZXN0cnUgU2Fkb3dlZ28gLSBLUlMgMTAxODgyIHwgTklQIDk1Ny0wNy01Mi0zMTYgfCBL
YXBpdGFsIHpha2xhZG93eSAyMDAuMDAwIFBMTi4KVGEgd2lhZG9tb3NjIHdyYXogeiB6YWxhY3pu
aWthbWkgamVzdCBwcnplem5hY3pvbmEgZGxhIG9rcmVzbG9uZWdvIGFkcmVzYXRhIGkgbW96ZSB6
YXdpZXJhYyBpbmZvcm1hY2plIHBvdWZuZS4gVyByYXppZSBwcnp5cGFka293ZWdvIG90cnp5bWFu
aWEgdGVqIHdpYWRvbW9zY2ksIHByb3NpbXkgbyBwb3dpYWRvbWllbmllIG5hZGF3Y3kgb3JheiB0
cndhbGUgamVqIHVzdW5pZWNpZTsgamFraWVrb2x3aWVrIHByemVnbGFkYW5pZSBsdWIgcm96cG93
c3plY2huaWFuaWUgamVzdCB6YWJyb25pb25lLgpUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1l
bnRzIG1heSBjb250YWluIGNvbmZpZGVudGlhbCBtYXRlcmlhbCBmb3IgdGhlIHNvbGUgdXNlIG9m
IHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCBy
ZWNpcGllbnQsIHBsZWFzZSBjb250YWN0IHRoZSBzZW5kZXIgYW5kIGRlbGV0ZSBhbGwgY29waWVz
OyBhbnkgcmV2aWV3IG9yIGRpc3RyaWJ1dGlvbiBieSBvdGhlcnMgaXMgc3RyaWN0bHkgcHJvaGli
aXRlZC4K

