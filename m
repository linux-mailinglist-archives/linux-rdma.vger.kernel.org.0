Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3D06AD32D
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Mar 2023 01:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjCGAJZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Mar 2023 19:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjCGAJY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Mar 2023 19:09:24 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775562F7B6;
        Mon,  6 Mar 2023 16:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678147762; x=1709683762;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FG7zczMAlvCz7HbjwHaDu9qLqfFgEcrURyDGG7B8xZk=;
  b=XGtuGXyO9tnZue+Z5ufpo8OPXH88SKLIbgnMAAPwQ/lv8C01ogBdUxFR
   bOo8wiXacCHET3LYW9vfX236K6QgxfUi5zY2r2qHExAbjZsmhwhQ5UZkx
   w9XbrckV0HYNuYNBQn/4T75PYNqZJxctKVstObXL3qsk2x2HKI3ZrwCS/
   Ek3W25OVyXeiMw5zANt+ghZGoVseNT8JLmovxh/V2s8orw1cjLqs+j5Cc
   NF7/4LlGHia9up6MSbguWj0zvOzp3Sg1xJxpL0N9BGaksTIieCFoRg9I2
   bcuw/DRZqUudDMhhtNERUxrlZOTmDb3sAgB/fOYbE9TUXFZruikn3HX2n
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="315371952"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="315371952"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 16:09:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="1005636358"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="1005636358"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 06 Mar 2023 16:09:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 16:09:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 16:09:21 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 6 Mar 2023 16:09:21 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 6 Mar 2023 16:09:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9NxDbLxYL3ifWMXu/yyeYbxjbiEGwKoqtM0VsEMu9HY+YG16byyVaVgW/4zQL2tpL+4PwQN0N7YBr+4a3pvQUa2VAvg2iJaDSNJwg3OgAw8H/ClH8CGoVgS+1VcUzqEuk+6KxxKXhUp2WRjB+UNh85ReJ4pP1aL+a1zOXgcb0V7vGN1sjK4NRYBBwImToa1c6V1WXufMTm4qYnw0vMYF8t3nwX4TnS4CfN7zmnZKJckmy/ud2H9NSRDvkN8aMIVHeL0p1SnisZf0FmCLPcgmxfh6Vs9+D5bi2Iq3RcYqfYkSA2eoGSW8EBRVMrFM7Bu01flA/au/p7+NLivFM7tHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FG7zczMAlvCz7HbjwHaDu9qLqfFgEcrURyDGG7B8xZk=;
 b=gz0cca/0npAtynI+1TkVmzykQ/phs/H7VKrefC2VSoCWOlr/C/tfmvm8S0cIOkjyXd7gKOAbjHd7VxCLZN7JNjNaBw940O5sNy/nwgITURADlC7xrURK9i6qc1h8K6xM5T/4M29CnDrI9V8dDbwjQTeg3V1IhiCtD/qqjNCO/DwiMZjGsGJ0REVca8ngHYM9jQ+WEyZiczRaMgLvJFjZjzOQ9ydJbCK8a4WKO/DgqHQaVXh1Q1EHYmnsMseqeV3HspGGaWcZnvjhmE1I24Ki4g8tzqv0H1ogtoh0zRldAkXRFf1YplvHtFBucX2RKq02hoKInTAxN1O5HmUnIv23Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by DS0PR11MB7927.namprd11.prod.outlook.com (2603:10b6:8:fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 00:09:18 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::b779:9f51:663e:4d9]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::b779:9f51:663e:4d9%7]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 00:09:17 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "Devale, Sindhu" <sindhu.devale@intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "devel@vger.kernel.org" <devel@vger.kernel.org>,
        Mike Christie <michael.christie@oracle.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
Subject: RE: [PATCH for-rc] IB/isert: Fix hang in iscsit_wait_for_tag
Thread-Topic: [PATCH for-rc] IB/isert: Fix hang in iscsit_wait_for_tag
Thread-Index: AQHZLEoLBwlby0anZU+QHxvMf7PVIq6rvveAgAatAxCABOX8MIAVkbSAgCHU2SA=
Date:   Tue, 7 Mar 2023 00:09:17 +0000
Message-ID: <MWHPR11MB00294E08888B739ADB064BC2E9B79@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <20230119210659.1871-1-shiraz.saleem@intel.com>
 <909684d4-f169-792b-7f84-ba18a6e19824@grimberg.me>
 <SA2PR11MB495347CE35C9ED97CD80C422F3CC9@SA2PR11MB4953.namprd11.prod.outlook.com>
 <SA2PR11MB4953D102791B458434A775FDF3D39@SA2PR11MB4953.namprd11.prod.outlook.com>
 <4df68538-6027-712b-8dac-e089d6f2192d@grimberg.me>
In-Reply-To: <4df68538-6027-712b-8dac-e089d6f2192d@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0029:EE_|DS0PR11MB7927:EE_
x-ms-office365-filtering-correlation-id: 96f8073a-a7e9-4103-9d87-08db1ea03193
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wcs2ZObFO73ee8m2vTenTUTm5w6m40z18j26zsrY88CW3R4YWHilsxxGrr8p8dDamNTNKEP0eBm1ZORPSvkfMF/PCedKwJWW5cPUt2ITQPIjKpvDB2yH0nbkhqZofU7ppjtDUk6K2merpYvab/jLfv6WBrF1zRvdqE/iKJBJlz845KZJtn5JaHXinJfhOeA4VgTTKPD0EvVuD46AWCWdq2uaAkEu70/ymr/vo9Q3DfIrn88X+tFbHsRy7CMz+rUS59tCOShTvdcIQWhE9ZoYm3u0LmEMqIZJS1zAt4xnjKNkchBOx+9udj4c7Xq9QlY5TkOw+jRJlteRhuoiN4BCJpAI4Ejge2AuzaruTQFJhp/iMda/gdIihgmf3ukeTrrRHunNJmZxpfJEtaj4kEyhqX8FLC1BdFyzsawvXS9rX/c3NUXRUAVLvy72vDwcd7H8YGzo/4PWOlRkjBYhPcpRsCda+TOuzG2YPO5R/M/C2OgmSDGqfeZVJfjBPUKCwCRZgUOIXXOE91QTJPTDowAFVKeSAis7CApRVGkJ0KPawT9GZ+yi1g3C1bq5d6KC7YpN7YkrH989FUrV1kJ2FjwRoNvtFTon9dwEsoAwVAGpip+NR68RBzJYirRcK+XKC0Gy2DNMMB3h/+4B9E37GQJ3VPAoRzwIukLWsc9tK/7KREYjmPOZSb+FZi3wLU+LGTx1lpyebgmqekps7lP3a/s8PQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199018)(76116006)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(4326008)(83380400001)(86362001)(186003)(9686003)(55016003)(38100700002)(38070700005)(82960400001)(122000001)(26005)(478600001)(110136005)(316002)(54906003)(33656002)(53546011)(6506007)(71200400001)(7696005)(5660300002)(2906002)(41300700001)(52536014)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVQxWVFpMk1uek4vdkQ4UHMrV0ZLcUJGcHJlcitMQzNDQ0tpUmpzSXNlbkdo?=
 =?utf-8?B?RW4yRnhWZ0ZhaFNycmFZYldLRy9VWVRFbE9admE3QUh2aUVkOXBCS2lGTE5F?=
 =?utf-8?B?QWMrU2FwSzJMNHphU21KRDZNS1Z6V0NGaG5YemtXRHRYNm5waSt3OTVsUDMx?=
 =?utf-8?B?Z1BOZXRhUVA0VWhsNjRNSXBNd2lJd3RyMmUyZWkxWEVoNHc2OVRycGJCS25T?=
 =?utf-8?B?Um5CQU80WXZoR2FQbFpIMFd1dDRQbi9oYVN2ZldQTVZCTjZyeTFnVWMvUXFm?=
 =?utf-8?B?cC9mbFJQNGJyVTVEZlk1RGViMCtFSXExZG56RFpKaVRGbXhPb0NpQnp1aUxl?=
 =?utf-8?B?S01Cb1Y5UVdsWHNlbEFsbDI4ZGI5ckFYaUJMMEp3UzkvMFJLWS8yYkxmdldk?=
 =?utf-8?B?WlFiM1BuMUdIUS9FOVRSUlZUTW5ZbHg2OWRwNVhtQkVxSWhEc2kxMlMyUXJV?=
 =?utf-8?B?a1ZCOGJJWit4SzZwVGx3TkpKZGFEcDM5WnJQeUI3WjRmQTlLMk9hZTI5cXBJ?=
 =?utf-8?B?L2RWS2Jrc2pCQUg1Mm9yVkNZZWliem5UaG03d1RqWVFHSjlVb2Y3aEZIOWZR?=
 =?utf-8?B?R3JnNU5vSzd4M0pvMSs0UWRSTjNqOVJJdHZ4YmFnME9LdXY0MHZMaUxHM1VX?=
 =?utf-8?B?YWcxVExIVit2VzQ0SGNmSUlVS24vSklYcnF1Qkx0dVdDak9GbWxKODRhbEFq?=
 =?utf-8?B?RUNab2UzYXRYQkFiZWFTeHBuTnN2eit4bHdhODlxVmdpWmx6SWQ5aDVmcTZl?=
 =?utf-8?B?U00zbVF2WksvOUZyUDVnVzNSOVEvK0pQaGFBS1Bieks3UFBYMEpTVGFEaEVj?=
 =?utf-8?B?azVtVnFlUkNUOXh6dHJLYk15TVJDcStDaXg2cmhCZzIwNFpwMk05Wnl6NWg4?=
 =?utf-8?B?TnR4WUJnUnBTUnBwTHprV0U4N0FIeWtVeTAzSDB3M0ZKRUcxYzVEODJYMVVQ?=
 =?utf-8?B?TFlnZ2lzdjNLQlRRSkRsTHQvNXEvbjVLT2ZiRjJBWG1ab3pxVU92dVRub2hU?=
 =?utf-8?B?dzZEeEFtZFpxZzZ1d2wzYnBTaW1oL3IrVWEzZkdHOWFhbmVXcVBramF4Zjlr?=
 =?utf-8?B?VGdKVWR2WW5zM3o5ZVZMYlcySElOOUpkdjJ4V2d1QWY4NkNFSU1YVnRlWisx?=
 =?utf-8?B?YWVMMXlTbitzUXROaFBWOThXdHducHRCVjRYYmdnUTc4aUZBbUdycXNpQ1cv?=
 =?utf-8?B?eUZTWGdTNTFtOXJkMVcxQm1xcHd5WGRzNHZDVTliSWkrdDZLdkF4aUZkUW44?=
 =?utf-8?B?QnlLQjVhTG5RbW1hd2hJSFRwL0wvYytlTTh5Mk5ua0QrUnJVZ2NFR09RVTJi?=
 =?utf-8?B?bVVNbHYybkpobWlRbEhmeXZaU0oyRi9pR2FXY2pVT01oSTI1U00xSGtoNmN0?=
 =?utf-8?B?L2pocVhkbnh0R1REWmlWOWxKVnQyWjFmdjhXTmdpS056TzY0VmVmdFczajU5?=
 =?utf-8?B?ODZTZXBxTlpiL0Z3djBOWjZMNGR3WUNhYzZiK2lRbmRHL09pK09tUWdHMVlF?=
 =?utf-8?B?WVp2UHZkdkd3TnFySjhrM0liQzNNaDFuZHd2OGszNU95bytxSS9QYkQ3VjlW?=
 =?utf-8?B?WmJTRytxTHZkbmtIc2J2MXgwU1haS3hCV0VrWTlUZEZQNWtxM0M3SWliaFp5?=
 =?utf-8?B?THZ3OWczZ3lNL2M4bTdUSVpHYVdoNElHMXpyOUU5TTBpU2NWL1RCblRybFRB?=
 =?utf-8?B?VW5taGtGNzRkcTNYQXFoRjJqZWNIRlZkbC9FditOWnR1Nm10ZUY4T2tvM0di?=
 =?utf-8?B?ZDJKZm9PU25NRzNnN2R2dWpubnJvRGIydVc2T0lkVUYxTDQ4cE8zTUpCakdY?=
 =?utf-8?B?Uy9YU29pTDZzV05oa2NKS3ZhOE1zaUZqcFh6Y1lseGlEWGhIYmd2UmVLRlJa?=
 =?utf-8?B?bXRERkV0R1hyb1NWTS9NcDhQKzJXd0FWK0wyUWVtaUdZU2lTdlc3UmhWZDQ4?=
 =?utf-8?B?b05LalFIOWNSdmVtMmJQU1djUWNqRVYza0xzKzBxbmRLL3BMa0J0b1RTM3RN?=
 =?utf-8?B?WUIvQUhQcnFwTjFSaFFTN1VWRkJpYkpPYVV6SnljZDduNE9Fb3Y5WTlOZFRL?=
 =?utf-8?B?S0NwNkQ4dHNCT29yQ1ZUOGI3NzNiaERWNHdOSUgycHVmM0NBOGxSd2dDRDlo?=
 =?utf-8?Q?UKg+CFxQrO7iB97XVaPm4S2az?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f8073a-a7e9-4103-9d87-08db1ea03193
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 00:09:17.7790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zx2yzdYw2btPG5pVmMWNIGfwqf7O073SPi2cYJtBrqaouObN1rQ1i9ZRM7o4ZHC/3yGJDf7vBh1MdtHTtN3ojA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7927
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIGZvci1yY10gSUIvaXNlcnQ6IEZpeCBoYW5nIGluIGlzY3Np
dF93YWl0X2Zvcl90YWcNCj4gDQo+IA0KPiANCj4gT24gMS8zMC8yMyAyMDoyMiwgRGV2YWxlLCBT
aW5kaHUgd3JvdGU6DQo+ID4NCj4gPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIGZvci1yY10g
SUIvaXNlcnQ6IEZpeCBoYW5nIGluIGlzY3NpdF93YWl0X2Zvcl90YWcNCj4gPj4NCj4gPj4NCj4g
Pj4+IEZyb206IE11c3RhZmEgSXNtYWlsIDxtdXN0YWZhLmlzbWFpbEBpbnRlbC5jb20+DQo+ID4+
Pg0KPiA+Pj4gUnVubmluZyBmaW8gY2FuIG9jY2FzaW9uYWxseSBjYXVzZSBhIGhhbmcgd2hlbiBz
Yml0bWFwX3F1ZXVlX2dldCgpDQo+ID4+PiBmYWlscyB0byByZXR1cm4gYSB0YWcgaW4gaXNjc2l0
X2FsbG9jYXRlX2NtZCgpIGFuZA0KPiA+Pj4gaXNjc2l0X3dhaXRfZm9yX3RhZygpIGlzIGNhbGxl
ZCBhbmQgd2lsbCBuZXZlciByZXR1cm4gZnJvbSB0aGUNCj4gPj4+IHNjaGVkdWxlKCkuIFRoaXMg
aXMgYmVjYXVzZSB0aGUgcG9sbGluZyB0aHJlYWQgb2YgdGhlIENRIGlzDQo+ID4+PiBzdXNwZW5k
ZWQsIGFuZCB3aWxsIG5vdCBwb2xsIGZvciBhIFNRIGNvbXBsZXRpb24gd2hpY2ggd291bGQgZnJl
ZSB1cCBhIHRhZy4NCj4gPj4+IEZpeCB0aGlzIGJ5IGNyZWF0aW5nIGEgc2VwYXJhdGUgQ1EgZm9y
IHRoZSBTUSBzbyB0aGF0IHNlbmQNCj4gPj4+IGNvbXBsZXRpb25zIGFyZSBwcm9jZXNzZWQgb24g
YSBzZXBhcmF0ZSB0aHJlYWQgYW5kIGFyZSBub3QgYmxvY2tlZA0KPiA+Pj4gd2hlbiB0aGUgUlEg
Q1EgaXMgc3RhbGxlZC4NCj4gPj4+DQo+ID4+PiBGaXhlczogMTBlOWNiYjZiNTMxICgic2NzaTog
dGFyZ2V0OiBDb252ZXJ0IHRhcmdldCBkcml2ZXJzIHRvIHVzZQ0KPiA+Pj4gc2JpdG1hcCIpDQo+
ID4+DQo+ID4+IElzIHRoaXMgdGhlIHJlYWwgb2ZmZW5kaW5nIGNvbW1pdD8gV2hhdCBwcmV2ZW50
ZWQgdGhpcyBmcm9tIGhhcHBlbmluZw0KPiA+PiBiZWZvcmU/DQo+ID4NCj4gPiBNYXliZSBnb2lu
ZyB0byBhIGdsb2JhbCBiaXRtYXAgaW5zdGVhZCBvZiBwZXIgY3B1IGlkYSBtYWtlcyBpdCBsZXNz
IGxpa2VseSB0bw0KPiBvY2N1ci4NCj4gPiBHb2luZyB0byBzaW5nbGUgQ1EgbWF5YmUgdGhlIHJl
YWwgcm9vdCBjYXVzZSBpbiB0aGlzDQo+ID4gY29tbWl0OjZmMGZhZTNkNzc5NygiaXNlci10YXJn
ZXQ6IFVzZSBzaW5nbGUgQ1EgZm9yIFRYIGFuZCBSWCIpDQo+IA0KPiBZZXMgdGhpcyBpcyBtb3Jl
IGxpa2VseS4NCj4gDQo+ID4NCj4gPj4+IFJldmlld2VkLWJ5OiBNaWtlIE1hcmNpbmlzenluIDxt
aWtlLm1hcmNpbmlzenluQGludGVsLmNvbT4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IE11c3RhZmEg
SXNtYWlsIDxtdXN0YWZhLmlzbWFpbEBpbnRlbC5jb20+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBT
aGlyYXogU2FsZWVtIDxzaGlyYXouc2FsZWVtQGludGVsLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4g
ICAgZHJpdmVycy9pbmZpbmliYW5kL3VscC9pc2VydC9pYl9pc2VydC5jIHwgMzMNCj4gPj4+ICsr
KysrKysrKysrKysrKysrKysrKysrLS0NCj4gPj4gLS0tLS0tLS0NCj4gPj4+ICAgIGRyaXZlcnMv
aW5maW5pYmFuZC91bHAvaXNlcnQvaWJfaXNlcnQuaCB8ICAzICsrLQ0KPiA+Pj4gICAgMiBmaWxl
cyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gPj4+DQo+ID4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3VscC9pc2VydC9pYl9pc2VydC5jDQo+
ID4+PiBiL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvaXNlcnQvaWJfaXNlcnQuYw0KPiA+Pj4gaW5k
ZXggNzU0MDQ4OC4uZjgyN2I5MSAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFu
ZC91bHAvaXNlcnQvaWJfaXNlcnQuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3Vs
cC9pc2VydC9pYl9pc2VydC5jDQo+ID4+PiBAQCAtMTA5LDE5ICsxMDksMjcgQEAgc3RhdGljIGlu
dCBpc2VydF9zZ190YWJsZXNpemVfc2V0KGNvbnN0IGNoYXINCj4gPj4+ICp2YWwsDQo+ID4+IGNv
bnN0IHN0cnVjdCBrZXJuZWxfcGFyYW0gKmtwDQo+ID4+PiAgICAJc3RydWN0IGliX3FwX2luaXRf
YXR0ciBhdHRyOw0KPiA+Pj4gICAgCWludCByZXQsIGZhY3RvcjsNCj4gPj4+DQo+ID4+PiAtCWlz
ZXJ0X2Nvbm4tPmNxID0gaWJfY3FfcG9vbF9nZXQoaWJfZGV2LCBjcV9zaXplLCAtMSwNCj4gPj4g
SUJfUE9MTF9XT1JLUVVFVUUpOw0KPiA+Pj4gLQlpZiAoSVNfRVJSKGlzZXJ0X2Nvbm4tPmNxKSkg
ew0KPiA+Pj4gLQkJaXNlcnRfZXJyKCJVbmFibGUgdG8gYWxsb2NhdGUgY3FcbiIpOw0KPiA+Pj4g
LQkJcmV0ID0gUFRSX0VSUihpc2VydF9jb25uLT5jcSk7DQo+ID4+PiArCWlzZXJ0X2Nvbm4tPnNu
ZF9jcSA9IGliX2NxX3Bvb2xfZ2V0KGliX2RldiwgY3Ffc2l6ZSwgLTEsDQo+ID4+PiArCQkJCQkg
ICAgSUJfUE9MTF9XT1JLUVVFVUUpOw0KPiA+Pj4gKwlpZiAoSVNfRVJSKGlzZXJ0X2Nvbm4tPnNu
ZF9jcSkpIHsNCj4gPj4+ICsJCWlzZXJ0X2VycigiVW5hYmxlIHRvIGFsbG9jYXRlIHNlbmQgY3Fc
biIpOw0KPiA+Pj4gKwkJcmV0ID0gUFRSX0VSUihpc2VydF9jb25uLT5zbmRfY3EpOw0KPiA+Pj4g
ICAgCQlyZXR1cm4gRVJSX1BUUihyZXQpOw0KPiA+Pj4gICAgCX0NCj4gPj4+ICsJaXNlcnRfY29u
bi0+cmN2X2NxID0gaWJfY3FfcG9vbF9nZXQoaWJfZGV2LCBjcV9zaXplLCAtMSwNCj4gPj4+ICsJ
CQkJCSAgICBJQl9QT0xMX1dPUktRVUVVRSk7DQo+ID4+PiArCWlmIChJU19FUlIoaXNlcnRfY29u
bi0+cmN2X2NxKSkgew0KPiA+Pj4gKwkJaXNlcnRfZXJyKCJVbmFibGUgdG8gYWxsb2NhdGUgcmVj
ZWl2ZSBjcVxuIik7DQo+ID4+PiArCQlyZXQgPSBQVFJfRVJSKGlzZXJ0X2Nvbm4tPnJjdl9jcSk7
DQo+ID4+PiArCQlnb3RvIGNyZWF0ZV9jcV9lcnI7DQo+ID4+PiArCX0NCj4gPj4NCj4gPj4gRG9l
cyB0aGlzIGhhdmUgYW55IG5vdGljZWFibGUgcGVyZm9ybWFuY2UgaW1wbGljYXRpb25zPw0KPiA+
DQo+ID4gSW5pdGlhbCB0ZXN0aW5nIHNlZW1zIHRvIGluZGljYXRlIHRoaXMgY2hhbmdlIGNhdXNl
cyBzaWduaWZpY2FudCBwZXJmb3JtYW5jZQ0KPiB2YXJpYWJpbGl0eSBzcGVjaWZpY2FsbHkgb25s
eSB3aXRoIDJLIFdyaXRlcy4NCj4gPiBXZSBzdXNwZWN0IHRoYXQgbWF5IGJlIGR1ZSBhbiB1bmZv
cnR1bmF0ZSB2ZWN0b3IgcGxhY2VtZW50IHdoZXJlIHRoZQ0KPiBzbmRfY3EgYW5kIHJjdl9jcSBh
cmUgb24gZGlmZmVyZW50IG51bWEgbm9kZXMuDQo+ID4gV2UgY2FuLCBpbiB0aGUgcGF0Y2gsIGFs
dGVyIHRoZSBzZWNvbmQgQ1EgY3JlYXRpb24gdG8gcGFzcyBjb21wX3ZlY3RvciB0bw0KPiBpbnN1
cmUgdGhleSBhcmUgaGludGVkIHRvIHRoZSBzYW1lIGFmZmluaXR5Lg0KPiANCj4gRXZlbiBzbywg
c3RpbGwgdGhlcmUgYXJlIG5vdyB0d28gY29tcGV0aW5nIHRocmVhZHMgZm9yIGNvbXBsZXRpb24g
cHJvY2Vzc2luZy4NCj4gDQo+ID4NCj4gPj4gQWxzbyBJIHdhbmRlciBpZiB0aGVyZSBhcmUgYW55
IG90aGVyIGFzc3VtcHRpb25zIGluIHRoZSBjb2RlIGZvcg0KPiA+PiBoYXZpbmcgYSBzaW5nbGUg
Y29udGV4dCBwcm9jZXNzaW5nIGNvbXBsZXRpb25zLi4uDQo+ID4NCj4gPiBXZSBkb24ndCBzZWUg
YW55Lg0KPiA+DQo+ID4+IEl0J2QgYmUgbXVjaCBlYXNpZXIgaWYgaXNjc2lfYWxsb2NhdGVfY21k
IGNvdWxkIGFjY2VwdCBhIHRpbWVvdXQgdG8gZmFpbC4uLg0KPiA+Pg0KPiA+PiBDQ2luZyB0YXJn
ZXQtZGV2ZWwgYW5kIE1pa2UuDQo+ID4NCj4gPiBEbyB5b3UgbWVhbiBhZGQgYSB0aW1lb3V0IHRv
IHRoZSB3YWl0IG9yIHJlbW92aW5nIHRoZSBjYWxsDQo+IHRvwqBpc2NzaXRfd2FpdF9mb3JfdGFn
KCkgaXNjc2l0X2FsbG9jYXRlX2NtZCgpPw0KPiANCj4gTG9va2luZyBhdCB0aGUgY29kZSwgcGFz
c2luZyBpdCBUQVNLX1JVTk5JTkcgd2lsbCBtYWtlIGl0IGZhaWwgaWYgdGhlcmUgbm8NCj4gYXZh
aWxhYmxlIHRhZyAoYW5kIGhlbmNlIGRyb3AgdGhlIHJlY2VpdmVkIGNvbW1hbmQsIGxldCB0aGUg
aW5pdGlhdG9yIHJldHJ5KS4gQnV0IEkNCj4gYWxzbyB0aGluayB0aGF0IGlzZXJ0IG1heSBuZWVk
IGEgZGVlcGVyIGRlZmF1bHQgcXVldWUgZGVwdGguLi4NCg0KSGkgU2FnaSAtDQoNCg0KTXVzdGFm
YSByZXBvcnRzIC0gIlRoZSBwcm9ibGVtIGlzIG5vdCBlYXNpbHkgcmVwcm9kdWNlZCwgc28gSSBy
ZWR1Y2UgdGhlIGFtb3VudCBvZiBtYXBfdGFncyBhbGxvY2F0ZWQgd2hlbiBJIHRlc3RpbmcgYSBw
b3RlbnRpYWwgZml4LiBQYXNzaW5nIFRBU0tfUlVOTklORyBhbmQgSSBnb3QgdGhlIGZvbGxvd2lu
ZyBjYWxsIHRyYWNlOg0KDQpbICAyMjAuMTMxNzA5XSBpc2VydDogaXNlcnRfYWxsb2NhdGVfY21k
OiBVbmFibGUgdG8gYWxsb2NhdGUgaXNjc2l0X2NtZCArIGlzZXJ0X2NtZA0KWyAgMjIwLjEzMTcx
Ml0gaXNlcnQ6IGlzZXJ0X2FsbG9jYXRlX2NtZDogVW5hYmxlIHRvIGFsbG9jYXRlIGlzY3NpdF9j
bWQgKyBpc2VydF9jbWQNClsgIDI4MC44NjI1NDRdIEFCT1JUX1RBU0s6IEZvdW5kIHJlZmVyZW5j
ZWQgaVNDU0kgdGFza190YWc6IDcwDQpbICAzMTMuMjY1MTU2XSBpU0NTSSBMb2dpbiB0aW1lb3V0
IG9uIE5ldHdvcmsgUG9ydGFsIDUuMS4xLjIxOjMyNjANClsgIDMzNC43NjkyNjhdIElORk86IHRh
c2sga3dvcmtlci8zMjozOjEyODUgYmxvY2tlZCBmb3IgbW9yZSB0aGFuIDMwIHNlY29uZHMuDQpb
ICAzMzQuNzY5MjcyXSAgICAgICBUYWludGVkOiBHICAgICAgICAgICBPRSAgICAgIDYuMi4wLXJj
MyAjNg0KWyAgMzM0Ljc2OTI3NF0gImVjaG8gMCA+IC9wcm9jL3N5cy9rZXJuZWwvaHVuZ190YXNr
X3RpbWVvdXRfc2VjcyIgZGlzYWJsZXMgdGhpcyBtZXNzYWdlLg0KWyAgMzM0Ljc2OTI3NV0gdGFz
azprd29ya2VyLzMyOjMgICAgc3RhdGU6RCBzdGFjazowICAgICBwaWQ6MTI4NSAgcHBpZDoyICAg
ICAgZmxhZ3M6MHgwMDAwNDAwMA0KWyAgMzM0Ljc2OTI3OV0gV29ya3F1ZXVlOiBldmVudHMgdGFy
Z2V0X3Rtcl93b3JrIFt0YXJnZXRfY29yZV9tb2RdDQpbICAzMzQuNzY5MzA3XSBDYWxsIFRyYWNl
Og0KWyAgMzM0Ljc2OTMwOF0gIDxUQVNLPg0KWyAgMzM0Ljc2OTMxMF0gIF9fc2NoZWR1bGUrMHgz
MTgvMHhhMzANClsgIDMzNC43NjkzMTZdICA/IF9wcmJfcmVhZF92YWxpZCsweDIyZS8weDJiMA0K
WyAgMzM0Ljc2OTMxOV0gID8gX19wZnhfc2NoZWR1bGVfdGltZW91dCsweDEwLzB4MTANClsgIDMz
NC43NjkzMjJdICA/IF9fd2FpdF9mb3JfY29tbW9uKzB4ZDMvMHgxZTANClsgIDMzNC43NjkzMjNd
ICBzY2hlZHVsZSsweDU3LzB4ZDANClsgIDMzNC43NjkzMjVdICBzY2hlZHVsZV90aW1lb3V0KzB4
MjczLzB4MzIwDQpbICAzMzQuNzY5MzI3XSAgPyBfX2lycV93b3JrX3F1ZXVlX2xvY2FsKzB4Mzkv
MHg4MA0KWyAgMzM0Ljc2OTMzMF0gID8gaXJxX3dvcmtfcXVldWUrMHgzZi8weDYwDQpbICAzMzQu
NzY5MzMyXSAgPyBfX3BmeF9zY2hlZHVsZV90aW1lb3V0KzB4MTAvMHgxMA0KWyAgMzM0Ljc2OTMz
M10gIF9fd2FpdF9mb3JfY29tbW9uKzB4ZjkvMHgxZTANClsgIDMzNC43NjkzMzVdICB0YXJnZXRf
cHV0X2NtZF9hbmRfd2FpdCsweDU5LzB4ODAgW3RhcmdldF9jb3JlX21vZF0NClsgIDMzNC43Njkz
NTFdICBjb3JlX3Rtcl9hYm9ydF90YXNrLmNvbGQuOCsweDE4Ny8weDIwMiBbdGFyZ2V0X2NvcmVf
bW9kXQ0KWyAgMzM0Ljc2OTM2OV0gIHRhcmdldF90bXJfd29yaysweGExLzB4MTEwIFt0YXJnZXRf
Y29yZV9tb2RdDQpbICAzMzQuNzY5Mzg0XSAgcHJvY2Vzc19vbmVfd29yaysweDFiMC8weDM5MA0K
WyAgMzM0Ljc2OTM4N10gIHdvcmtlcl90aHJlYWQrMHg0MC8weDM4MA0KWyAgMzM0Ljc2OTM4OV0g
ID8gX19wZnhfd29ya2VyX3RocmVhZCsweDEwLzB4MTANClsgIDMzNC43NjkzOTFdICBrdGhyZWFk
KzB4ZmEvMHgxMjANClsgIDMzNC43NjkzOTNdICA/IF9fcGZ4X2t0aHJlYWQrMHgxMC8weDEwDQpb
ICAzMzQuNzY5Mzk1XSAgcmV0X2Zyb21fZm9yaysweDI5LzB4NTANClsgIDMzNC43NjkzOTldICA8
L1RBU0s+DQpbICAzMzQuNzY5NDQyXSBJTkZPOiB0YXNrIGlzY3NpX25wOjUzMzcgYmxvY2tlZCBm
b3IgbW9yZSB0aGFuIDMwIHNlY29uZHMuDQpbICAzMzQuNzY5NDQ0XSAgICAgICBUYWludGVkOiBH
ICAgICAgICAgICBPRSAgICAgIDYuMi4wLXJjMyAjNg0KWyAgMzM0Ljc2OTQ0NF0gImVjaG8gMCA+
IC9wcm9jL3N5cy9rZXJuZWwvaHVuZ190YXNrX3RpbWVvdXRfc2VjcyIgZGlzYWJsZXMgdGhpcyBt
ZXNzYWdlLg0KWyAgMzM0Ljc2OTQ0NV0gdGFzazppc2NzaV9ucCAgICAgICAgc3RhdGU6RCBzdGFj
azowICAgICBwaWQ6NTMzNyAgcHBpZDoyICAgICAgZmxhZ3M6MHgwMDAwNDAwNA0KWyAgMzM0Ljc2
OTQ0N10gQ2FsbCBUcmFjZToNClsgIDMzNC43Njk0NDddICA8VEFTSz4NClsgIDMzNC43Njk0NDhd
ICBfX3NjaGVkdWxlKzB4MzE4LzB4YTMwDQpbICAzMzQuNzY5NDUxXSAgPyBfX3BmeF9zY2hlZHVs
ZV90aW1lb3V0KzB4MTAvMHgxMA0KWyAgMzM0Ljc2OTQ1M10gID8gX193YWl0X2Zvcl9jb21tb24r
MHhkMy8weDFlMA0KWyAgMzM0Ljc2OTQ1NF0gIHNjaGVkdWxlKzB4NTcvMHhkMA0KWyAgMzM0Ljc2
OTQ1Nl0gIHNjaGVkdWxlX3RpbWVvdXQrMHgyNzMvMHgzMjANClsgIDMzNC43Njk0NTldICA/IGlz
Y3NpX3VwZGF0ZV9wYXJhbV92YWx1ZSsweDI3LzB4NzAgW2lzY3NpX3RhcmdldF9tb2RdDQpbICAz
MzQuNzY5NDc2XSAgPyBfX2ttYWxsb2Nfbm9kZV90cmFja19jYWxsZXIrMHg1Mi8weDEzMA0KWyAg
MzM0Ljc2OTQ3OF0gID8gX19wZnhfc2NoZWR1bGVfdGltZW91dCsweDEwLzB4MTANClsgIDMzNC43
Njk0ODBdICBfX3dhaXRfZm9yX2NvbW1vbisweGY5LzB4MWUwDQpbICAzMzQuNzY5NDgxXSAgaXNj
c2lfY2hlY2tfZm9yX3Nlc3Npb25fcmVpbnN0YXRlbWVudCsweDFlOC8weDI4MCBbaXNjc2lfdGFy
Z2V0X21vZF0NClsgIDMzNC43Njk0OTZdICBpc2NzaV90YXJnZXRfZG9fbG9naW4rMHgyM2IvMHg1
NzAgW2lzY3NpX3RhcmdldF9tb2RdDQpbICAzMzQuNzY5NTA4XSAgaXNjc2lfdGFyZ2V0X3N0YXJ0
X25lZ290aWF0aW9uKzB4NTUvMHhjMCBbaXNjc2lfdGFyZ2V0X21vZF0NClsgIDMzNC43Njk1MTld
ICBpc2NzaV90YXJnZXRfbG9naW5fdGhyZWFkKzB4Njc1LzB4ZWIwIFtpc2NzaV90YXJnZXRfbW9k
XQ0KWyAgMzM0Ljc2OTUzMV0gID8gX19wZnhfaXNjc2lfdGFyZ2V0X2xvZ2luX3RocmVhZCsweDEw
LzB4MTAgW2lzY3NpX3RhcmdldF9tb2RdDQpbICAzMzQuNzY5NTQxXSAga3RocmVhZCsweGZhLzB4
MTIwDQpbICAzMzQuNzY5NTQzXSAgPyBfX3BmeF9rdGhyZWFkKzB4MTAvMHgxMA0KWyAgMzM0Ljc2
OTU0NF0gIHJldF9mcm9tX2ZvcmsrMHgyOS8weDUwDQpbICAzMzQuNzY5NTQ3XSAgPC9UQVNLPg0K
DQoNClsgIDE4NS43MzQ1NzFdIGlzZXJ0OiBpc2VydF9hbGxvY2F0ZV9jbWQ6IFVuYWJsZSB0byBh
bGxvY2F0ZSBpc2NzaXRfY21kICsgaXNlcnRfY21kDQpbICAyNDYuMDMyMzYwXSBBQk9SVF9UQVNL
OiBGb3VuZCByZWZlcmVuY2VkIGlTQ1NJIHRhc2tfdGFnOiA3NQ0KWyAgMjc4LjQ0MjcyNl0gaVND
U0kgTG9naW4gdGltZW91dCBvbiBOZXR3b3JrIFBvcnRhbCA1LjEuMS4yMTozMjYwDQoNCg0KQnkg
dGhlIHdheSBpbmNyZWFzaW5nIHRhZ19udW0gaW4gaXNjc2lfdGFyZ2V0X2xvY2F0ZV9wb3J0YWwo
KSB3aWxsIGFsc28gYXZvaWQgdGhlIGlzc3VlIg0KDQpBbnkgdGhvdWdodHMgb24gd2hhdCBjb3Vs
ZCBiZSBjYXVzaW5nIHRoaXMgaGFuZz8NCg0KU2hpcmF6DQo=
