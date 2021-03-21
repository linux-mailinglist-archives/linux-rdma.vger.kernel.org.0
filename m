Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0BB343456
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Mar 2021 20:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhCUTTc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Mar 2021 15:19:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:51433 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230064AbhCUTTE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Mar 2021 15:19:04 -0400
IronPort-SDR: U4GX2daFEBzL2zkR9RaTSKMsOttqkvprmuq5njQdrYLnsAu7x/INEA/nRgfmrowuNLgvUXsPux
 8SqgzSNSnRYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9930"; a="189557277"
X-IronPort-AV: E=Sophos;i="5.81,266,1610438400"; 
   d="scan'208";a="189557277"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2021 12:19:03 -0700
IronPort-SDR: CH0orRdKkzlpE2vm910srsTKN7Io3KEU1Y9xEr2zLm65AJ2Yf3usN9KOnKgDj8iJIg97DwWid+
 3QTsutaGKAWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,266,1610438400"; 
   d="scan'208";a="434894964"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga004.fm.intel.com with ESMTP; 21 Mar 2021 12:19:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 21 Mar 2021 12:19:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Sun, 21 Mar 2021 12:19:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Sun, 21 Mar 2021 12:19:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqt/U3LewJ6eR3koiQ6S5lcpg63ZhkrkCZfoLR5OmsKr/d/adE7KFdDK+hb28g/PYXMZLO4i49fU92W4YxoJOfNYlRrn6bAdlx9LwXjrMXhy2i94cFcXCM/AGX1tkCCJGng3jOYTHOHDBkvDrEC0vty+WvHEWq+1a1j0Hnk80pJOGc8DCiF1CS/4CIWe/Y7RVxqO5sn9CjK4nFeI3Li5dse0vHkq5tS83FjrGe3JmwX1U4wQZs6QCTxlGboESlMAg0pOiVOXQEdlDAI1svRZU44pAWA3uDhqfxuLkwQx8E7hEEyMs2UQa6zP9hpqmjstTA1Kwoo/8Kmun4I+S1H4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1oFo4ivUJuWIw4S7dyNLmws5TJV5iqASPARVYqrbls=;
 b=VRczLud0PGUe7Ml8/I0wwgN8v6RUzD8Ho9mvhU2mbTnY8a00sV2rXqy38pk6HFjeuMf+VWomZdfvoPKKqWTsoRmV/eIDNn5O8plRh10dz7b9QwlY0r6vjXSvEEifjlj7m4PCW3QdNRO7yPfiH6Pk/Sr+Nf4OV7Z6fvkwuvvnle8sLdahifPr7cvgiKv0JVmsog5R0Bd0RLVzCPQHetg7X48tw1/z0+IOXTH5UiPlaD3XiBxcxu+mTlcxeGYURcJOul8X2gXu2FcoNoWBPLZQcdk3yT0Cn5RVNAI0fQmCO5gkB77Wc2i8eq8zcHzZbiOrp3XnJwdx0QEF2cXOcJBkuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1oFo4ivUJuWIw4S7dyNLmws5TJV5iqASPARVYqrbls=;
 b=U8LgkoHMMvIave2DmzYsjE1yNW2Aea6otYeJLqOhzqBLtPy+7nfnR6WTT+fMdcrxT0YwZa9WC7uQWQmhLegHprS7eoo5J9Pa3lMGVpSZojkNIwaPKO6MpCOWZIUjsHVI2mRZvD7zAItC50psYH7i7wX4ZXRGy1QDkmARBF8E6Yc=
Received: from DM6PR11MB3306.namprd11.prod.outlook.com (2603:10b6:5:5c::18) by
 DM5PR1101MB2203.namprd11.prod.outlook.com (2603:10b6:4:52::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.24; Sun, 21 Mar 2021 19:19:01 +0000
Received: from DM6PR11MB3306.namprd11.prod.outlook.com
 ([fe80::a5d3:6423:7589:c110]) by DM6PR11MB3306.namprd11.prod.outlook.com
 ([fe80::a5d3:6423:7589:c110%6]) with mapi id 15.20.3955.023; Sun, 21 Mar 2021
 19:19:01 +0000
From:   "Wan, Kaike" <kaike.wan@intel.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        "Rimmer, Todd" <todd.rimmer@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH RFC 0/9] A rendezvous module
Thread-Topic: [PATCH RFC 0/9] A rendezvous module
Thread-Index: AQHXHL9OhYUmp6U+V0qfjE0DBnim76qLVNwAgAAMHVCAABQIgIAAO/qAgAAGJwCAAAexAIAAA/SAgAAFugCAAAIfAIAAAPRwgAAIdwCAABjkAIABKNgAgAEQ+ACAAH0jgIAABbUAgAAKGgCAAB+bsA==
Date:   Sun, 21 Mar 2021 19:19:01 +0000
Message-ID: <DM6PR11MB33063495152BA25C12C27E90F4669@DM6PR11MB3306.namprd11.prod.outlook.com>
References: <BL0PR11MB3299928351B241FAAC76E760F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319202627.GC2356281@nvidia.com>
 <BL0PR11MB3299C202FCFF25646BFEE9B6F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319205432.GE2356281@nvidia.com>
 <SN6PR11MB3311F22207FDCA37B3A3C07AF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <29607fd4-906d-7d0d-2940-62ff5c8c9ec6@cornelisnetworks.com>
 <BL0PR11MB329976F1C41951957E2DBE79F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <be96ccbb-17b7-27e3-a4f2-5b2cc4184ecc@cornelisnetworks.com>
 <YFcKTjU9JSMBrv0x@unreal>
 <bc56284b-f517-2770-16ec-b98d95caea6f@cornelisnetworks.com>
 <20210321164504.GS2356281@nvidia.com>
 <1aaf8fd0-66c5-b804-26dc-c30a427564fa@cornelisnetworks.com>
In-Reply-To: <1aaf8fd0-66c5-b804-26dc-c30a427564fa@cornelisnetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [96.227.240.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4af9190b-9955-4ede-477d-08d8ec9e2f84
x-ms-traffictypediagnostic: DM5PR1101MB2203:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB220332C768DFB4CAF677B05AF4669@DM5PR1101MB2203.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RM9TOClzyN5ZC1dYj8NYkCrZQaMLbNw0x3K3YjvzfXLgrzj2AvxmO+FP/QbAUj6TpmlWMXdnVSxvqHb0D4w4FAiRrwdbi0KuEufqafbaTCd5rJBlf9UR+yQvC+xA/41+I7xDXAJ5O+Ku08/USrN6fo1HiBchCZ2fPNwwJZEUi1d3ot61Ss64fjprbAXMmxcwpuJar8K/sLPT2WQV2V3xrlVmGrcp79R4vgLY4dmAys0cfIb14dKxnPPaVdjft1Y1U18SLI2zhy1iXjzOFOz+pPoGjnl1XppJaOQeUUVF7UTTCx2JIu2wg1C1Mfw9JNfCKCXMf5cXICKNI7wnrpdzVcELxHCxpFIoEf2z8rK1b98pqxXQSeD7Ya6HlpKlEqxvQKbHdX8yC0imWj7aZt7GDoXZWKl6CWXNzILPiwUMie0z9WMuCd/65iA9rF+P6P9oixIZZ2ME9ouEvmTptBuy4pvJvKftY7kT/jxGz6CXLUjxbUjC9cWcdEdfkxGvfjnGJGaoaJp0It+J7/a2ZOMxGVQAIJVT2PNHWjt36KPhO+a+0DMBkFmjdxLrCGqSNh/iJx2Vz8kPJNoz1w+DAkXx5L9JO539EIgkmwYegmuBsosdlLHU0Ve9dZXk8N41SVkB+mkwB1VTTBmf/KEnwdLZJ11Zq3cwfcWR370prdIGCpE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3306.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(366004)(376002)(136003)(7696005)(83380400001)(2906002)(316002)(54906003)(110136005)(9686003)(86362001)(478600001)(33656002)(55016002)(66476007)(66556008)(64756008)(76116006)(66946007)(66446008)(8936002)(26005)(186003)(4326008)(8676002)(6506007)(53546011)(71200400001)(5660300002)(38100700001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RHczUXV0cHFqZnY4dWJJQ3ZJN2Y2Y2xGMnVGQ1loUDJJZWpOYmp0MitqZmpw?=
 =?utf-8?B?cWhEdUNEa0xRNkwyNFBIb3Z1NjE2UmJkNy9xcVl2bzkxYTRzTjlMMjJRQ0l1?=
 =?utf-8?B?YkpXTjNna284MThnaXVMYmpoVjExOWhaRksvWHFRZkRrUVRENkRsM3lxMXZx?=
 =?utf-8?B?N1lWMEliTmpzL2V5Zkx1SmM3bE5KUzdITVZuNVloOTVsRmtkU2FFRThBblJQ?=
 =?utf-8?B?bnFFK2lvWDRXZGlzL0xaOFdmS3ZnTUkxajl1OHhXcGd5enU5OUtua2tEaTd6?=
 =?utf-8?B?OTlqSnJWYkVoaXhoNjI2Ui9mSGxzejJNVlRWdHc5cWN1bWJUbkc2eFM2TzNL?=
 =?utf-8?B?dlFNay9FY3JBQnR6cmNQOTV6MjZ0aHI4bWc1RjNaY1JNOWFlTktNQkwvMVVM?=
 =?utf-8?B?OHNpQ1pBWXpFQzdtOXpzYSsrVnRjUU9nM0ZQd1NCdE0xWmpKalFGby9NOFNw?=
 =?utf-8?B?cFk4UHVRcS9kZDFiQ3d0WmFMMU5XclNuMHFQVUdEUmpsYVo5SmxTQXJXQ29H?=
 =?utf-8?B?aFc0QUdMUnd3cXd2NWZUZExTNTEvZStRYjNIRWgrZ3Z3VEYvTTB0cWJoODUy?=
 =?utf-8?B?aTlKRVN6MEU4bG9pelRCR3RBdzJCUXBTQTh1QjlIVUNYZU0zMnZLZWtQSk40?=
 =?utf-8?B?VkZINnZFQzZaZjJnVFI2WGNmZGF3c3c2dC9JSGozZTZRQkNiaWxFSkxLc1N6?=
 =?utf-8?B?ajRkSGJobzNwMmZyeXBkUVFodytzNG5PT2dTck11aTFhaFNkamxGdlFVZkxD?=
 =?utf-8?B?T3JCbFd0UDc3TkgvTHQzczlweTFpY3pVaUxMQVI5OEpoaXk1R1grMUpXT1BD?=
 =?utf-8?B?eGdOMnJXRGg4VjhSVkhzRXRJcDFjVXhTZ0k1dTk5d3VGN1lzVUdQSTQ0UGRx?=
 =?utf-8?B?bUpBam9ranMvcjdWdndKci9LSzhYZDdwUVYvNGV3UnYvYnZTSUx6cE5oUkpw?=
 =?utf-8?B?ZjZtVlRIRTczZTRwTGR1emowSmJQTEdvUDRrQ3E5SHc1c3NVSjRqL2F6SnBK?=
 =?utf-8?B?SW9uZE1HcDNTY09Cc3Q5U0FiUDZaU0F4N1dSb2p3R056Mit2emtXRjNpNURa?=
 =?utf-8?B?MFVKYzlpS1ZIQUJBRmRzU1pFcHBoNDR6ZmNOWmUzWHhVZS9TNTdaN2xOQnRO?=
 =?utf-8?B?cUJOU05TZDRhZkpxQzEvUGpFbmE0WmhVQWJSL241VVJ1enoveS8xMDk0SHIx?=
 =?utf-8?B?a2JxcDdLWllKdUpDRGRIWGgzUHFYbHUwaXJyN3BrMTdIVmxUam5QRndsVWRt?=
 =?utf-8?B?Nm1LN0RKU2pKY2J5UjFnTll3VTNVUDZ6L0lPQ2pYd25MS3JRWEZseHVsZEht?=
 =?utf-8?B?OXloMkZiRWQ5eXpOZFdJZkt1NFBneWcxeDJDL3lEejd3eFN3U01NRnA3V2x0?=
 =?utf-8?B?QzVuSW9lY1VIR05aVU5GeUdtR3kwSEF4RWdhTnpmQjRLN1J1MmttQm5SQ0xT?=
 =?utf-8?B?Uk03NmQ2ZnZRa0N2QTU1akIySXpzYmVzbXdxQXRvYkFZTm5Xb0tCamlFV3Y5?=
 =?utf-8?B?SnN1QXFWaGJ5M2FIL0dGTzJaYit4NTBxL2FtL2h5ZVIxa0hxbzlsaXhQOG82?=
 =?utf-8?B?VjdPakpQN2oydWMvUXJ2c3J3NFR3YllmUTJHa0JsMjNNeUhrWTV0RXluYXdZ?=
 =?utf-8?B?YnQrb2xrTVg0bkc5S3lBS0FYNlFiQnY4SlVQNmhvUWFRU2J3WEsxVnlFd3VU?=
 =?utf-8?B?NkVZZFdDRlRHRnZVay9QWUxZcTlYSlFTVHVMQ29CM0tOeTduN3hwZ0xCVGRO?=
 =?utf-8?Q?6b/TFCTyo6UpneoZirzSMCkD+2Vf9s6zAUF3Ojq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3306.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af9190b-9955-4ede-477d-08d8ec9e2f84
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2021 19:19:01.8081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jyh3APtdZ06umAzPi0yPWgix4eOqA4Nja3oXIFhac5C18Z68KSfxJwgdQFjf2GgiK/YQtVIbvZy6iI6nAynIJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2203
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBEZW5uaXMgRGFsZXNzYW5kcm8gPGRlbm5pcy5kYWxlc3NhbmRyb0Bjb3JuZWxpc25l
dHdvcmtzLmNvbT4NCj4gU2VudDogU3VuZGF5LCBNYXJjaCAyMSwgMjAyMSAxOjIxIFBNDQo+IFRv
OiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBDYzogTGVvbiBSb21hbm92c2t5
IDxsZW9uQGtlcm5lbC5vcmc+OyBSaW1tZXIsIFRvZGQNCj4gPHRvZGQucmltbWVyQGludGVsLmNv
bT47IFdhbiwgS2Fpa2UgPGthaWtlLndhbkBpbnRlbC5jb20+Ow0KPiBkbGVkZm9yZEByZWRoYXQu
Y29tOyBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFJG
QyAwLzldIEEgcmVuZGV6dm91cyBtb2R1bGUNCj4gDQo+IE9uIDMvMjEvMjAyMSAxMjo0NSBQTSwg
SmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiA+IE9uIFN1biwgTWFyIDIxLCAyMDIxIGF0IDEyOjI0
OjM5UE0gLTA0MDAsIERlbm5pcyBEYWxlc3NhbmRybyB3cm90ZToNCj4gPj4gT24gMy8yMS8yMDIx
IDQ6NTYgQU0sIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gPj4+IE9uIFNhdCwgTWFyIDIwLCAy
MDIxIGF0IDEyOjM5OjQ2UE0gLTA0MDAsIERlbm5pcyBEYWxlc3NhbmRybyB3cm90ZToNCj4gPj4+
PiBPbiAzLzE5LzIwMjEgNjo1NyBQTSwgUmltbWVyLCBUb2RkIHdyb3RlOg0KPiA+Pj4+Pj4+IFtX
YW4sIEthaWtlXSBJbmNvcnJlY3QuIFRoZSBydiBtb2R1bGUgd29ya3Mgd2l0aCBoZmkxLg0KPiA+
Pj4NCj4gPj4+IDwuLi4+DQo+ID4+Pg0KPiA+Pg0KPiA+Pj4gMi4gRmluZCBhbm90aGVyIHZlbmRv
ciB0aGF0IGp1bXBzIG9uIHRoaXMgUlYgYmFuZHdhZ29uLg0KPiA+Pg0KPiA+PiBUaGF0J3Mgbm90
IGEgdmFsaWQgYXJndW1lbnQuIENsZWFybHkgdGhpcyB3b3JrcyBvdmVyIG11bHRpcGxlIHZlbmRv
cnMgSFcuDQo+ID4NCj4gPiBBdCBhIGNlcnRhaW4gcG9pbnQgd2UgaGF2ZSB0byBkZWNpZGUgaWYg
dGhpcyBpcyBhIGdlbmVyaWMgY29kZSBvZiBzb21lDQo+ID4ga2luZCBvciBhIGRyaXZlci1zcGVj
aWZpYyB0aGluZyBsaWtlIEhGSSBoYXMuDQo+ID4NCj4gPiBUaGVyZSBhcmUgYWxzbyBvYnZpb3Vz
IHRlY2huaWFsIHByb2JsZW1zIGRlc2lnbmluZyBpdCBhcyBhIFVMUCwgc28gaXQNCj4gPiBpcyBh
IHZlcnkgaW1wb3J0YW50IHF1ZXN0aW9uIHRvIGFuc3dlci4gSWYgaXQgd2lsbCBvbmx5IGV2ZXIg
YmUgdXNlZA0KPiA+IGJ5IG9uZSBJbnRlbCBldGhlcm5ldCBjaGlwIHRoZW4gbWF5YmUgaXQgaXNu
J3QgcmVhbGx5IGdlbmVyaWMgY29kZS4NCj4gDQo+IFRvZGQvS2Fpa2UsIGlzIHRoZXJlIHNvbWV0
aGluZyBpbiBoZXJlIHRoYXQgaXMgc3BlY2lmaWMgdG8gdGhlIEludGVsIGV0aGVybmV0DQo+IGNo
aXA/DQpbV2FuLCBLYWlrZV0gTm8uIFRoZSBjb2RlIGlzIGdlbmVyaWMgdG8gVmVyYnMvUk9DRSBk
ZXZpY2VzLg0KDQo=
