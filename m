Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43556DCF61
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Apr 2023 03:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjDKBeH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Apr 2023 21:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjDKBdi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Apr 2023 21:33:38 -0400
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADBB2736;
        Mon, 10 Apr 2023 18:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1681176816; x=1712712816;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6PXpUDRSva0PU9PmOMOKs8SYd8Fu8RWqY6U/ZkIggSs=;
  b=zNVb4IoIOAYKncoL0f1pvgfKeRpdlH/nNoY64ksmbi+0jXhJfrm623C5
   RlmrqEtHsy7pBLXYnEwBz06QsOVXE93QFzSuxm36wwMJTEjx/GhBKPpUl
   AeXqTpeKHUlnqbBGSDOzjgCmSGiI4k9nSw2yAmxNMcBvdgSJEnL8U/J85
   zjMgZ/1gseFfUuP25e9JGA0CEydl4FtfA3GzYOwghdTKgqwqUo927kNqF
   UA1268vlGRzWgU9nvOC0Q/XB2XqaB4vgdiI4PWd9KNEEu+hA1bEv1LA3W
   Jj91TU7pxLik/iBjJmaZgSQt/erPHL9EjmbAx7Oc4bBuvw2Tz4NsSE1/4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="81385554"
X-IronPort-AV: E=Sophos;i="5.98,335,1673881200"; 
   d="scan'208";a="81385554"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 10:33:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6tFTVMzIDjG2k31MryQbOz1QWiydxGJajZOpOLz35nDAS+xB3+wmNWZs+paLhqO06OgjcmoNCZEBh4ZR+amuPyjihp+8+Q/S6oIxyPmuwYEA8GbgkPdts4TTDxasT8drVR68xFT8Fc7kGasPcGIOo4do2IQUDXGD2NEtyzGUXSpscuLUPksEMaom3FJcRqm+ScYxR/zM62pe61IuylKt91UjPjTxw9NIkrNj2FqITCrOrBWWXEVy7du5TrYl00B8KjInTYHZ42BowBPVm0VxcvP8iiLph4IsV7229msQu6D/swIz8ij5BZZgFsc8mxIOo68rfveYt1Qgps6XNBT/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PXpUDRSva0PU9PmOMOKs8SYd8Fu8RWqY6U/ZkIggSs=;
 b=mvPKmMTNs7Th0pS3K9ujaCTMH9mfvK1NLpnn+IlQJP4s+NmuwURgni+Grv7mgeBlP9MFBwNZZK9/LiI8g4ETPr/E2WLziFv/aNV0khMnDqk7TRxF0MamiJ9RD7iM4Qg6554271RLraKdVrHBNG7rPKp8SN68zsQ8H/onaTnhG+a7xP9FudmugVBemnQ8MUhtqJ5Y0tkJPRR7XI1Hoys2GJbW5ByVbcyBi30YBFnb7Vc3Xw+BwqcyDarFmHXJRkOrEOe+tTmLNk7nEhgLMWmNNCRt1CP8FevZLMVrFIqSDCV0a24XodYP1qjIv11nZdCQm0Q0NmZc7opQ2EXJDpjACQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB10931.jpnprd01.prod.outlook.com
 (2603:1096:400:3b3::10) by TYWPR01MB10330.jpnprd01.prod.outlook.com
 (2603:1096:400:24a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 01:33:28 +0000
Received: from TY3PR01MB10931.jpnprd01.prod.outlook.com
 ([fe80::3077:9807:4bb6:b7]) by TY3PR01MB10931.jpnprd01.prod.outlook.com
 ([fe80::3077:9807:4bb6:b7%7]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 01:33:28 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next 3/3] RDMA/rtrs: Avoid use-after-free in
 rtrs_clt_rdma_cm_handler
Thread-Topic: [PATCH for-next 3/3] RDMA/rtrs: Avoid use-after-free in
 rtrs_clt_rdma_cm_handler
Thread-Index: AQHZa3fJffiIp8+J90eMUK6yZ7KSMK8khXmAgADO0AA=
Date:   Tue, 11 Apr 2023 01:33:28 +0000
Message-ID: <1e1c082c-0c94-6594-d02c-9f7fbab80b0b@fujitsu.com>
References: <1681108984-2-1-git-send-email-lizhijian@fujitsu.com>
 <1681108984-2-4-git-send-email-lizhijian@fujitsu.com>
 <46aa88fe-89f0-6880-9bb7-081d1d18023b@linux.dev>
In-Reply-To: <46aa88fe-89f0-6880-9bb7-081d1d18023b@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB10931:EE_|TYWPR01MB10330:EE_
x-ms-office365-filtering-correlation-id: f6c06393-3620-4fe4-1c07-08db3a2cc095
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fEv5gEa3e0kHwgMfNnPqoN9KORGYEnr3+LmcYGqmIyQ8dtBdvBrBb21pt0yJXBKybPisgv9qrq2cGTRKs/FOZMxQ0m+4P5d/ZsPPp2riddCJqwI2WOVQPd4HRX8BnF4Ie90RNgeCxALzxS3IqM0onoX48brYV3imycegFW3PlDY5Aut56gUOhwzKHpUqB2pNEEewWlBS5db3VMbHnrhsx4ASbyJaqlTaiFC8BQluGFCyR+luHhOznSyQ95JwgGkf78+6S2gxMOhyiacGJd6CeHEKNvBBxetblS3jm4szBJneHS8o4S4PoJnsNnj5EXnU7bfyCIStEZDTBSgDnqSHoicGhralAjBngpWkkLZidXd9g7sP/wKb96P2KfX3Eh3ISaHTkU7u9DrzRIXxujVt0oixUwRKcar92M6Qbp4h0ytiRzFMBlDcQDLTk53+0ZzclYhJBed7gQx3clCHEUGVx9imdlMuR+nSP/h111WSw7ien0WwH1uskG5qTsV9rs7dHCqJNq3f7HPwXQhCCz9Gz+2bbq9XEFoT/tIhMmtAJmt0/XhQConjyW88BLrCeDQAcpLjX3oKGZ62PKrArAvSlp+A5OYsrYlSFmXv5TYxWG0oiboqnQunNSxguGo5QC4oV20aN53r87Jg6RVyJ4oIJ62X+K0DH1uGM7cVxC2jZ7wLBLgobuLgOaVEQiskVIhqAGRqu4qHWK9SObmOABgPlg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10931.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199021)(1590799018)(71200400001)(45080400002)(478600001)(6512007)(316002)(110136005)(53546011)(26005)(6506007)(186003)(6486002)(91956017)(2906002)(5660300002)(4326008)(66946007)(76116006)(66446008)(41300700001)(8676002)(66476007)(64756008)(8936002)(66556008)(38100700002)(38070700005)(122000001)(31696002)(86362001)(83380400001)(85182001)(36756003)(82960400001)(2616005)(31686004)(1580799015)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1FQY0tiSzZCYkt1R0ZLNW54SW03TWhwMk55aDN4OHpzcFNwT3dvbG00M3RD?=
 =?utf-8?B?cVRVTFZkN01BcVc0cnBTdHZXNStWK1VxUVl1ekFjWExTV0lPbGtqU2VDMnN1?=
 =?utf-8?B?L3IzYTZ3ZEpwMDh0NmRGV1I5RE5IVHlHUVNjYjdoNmpCSHNmVW8yQUo0ejQy?=
 =?utf-8?B?MkR1ejg0RGFRd3g4L0FJamxZSUh1UDRpRHU2cjFwV24vclk2SEdJdHNyV3NY?=
 =?utf-8?B?Nld0SitKdDl1TkU2RVQyUkZyYWhHY0tCMENLMTk5K24zZDQyam1xV0ZhNzV6?=
 =?utf-8?B?SEVkNWdxZVFOY3FKZDdmenZoNHY4U1Bxb1F5dlJxSk50RHhWN0RWdFA0aWxa?=
 =?utf-8?B?UHBBZVNxT1hVY3lidEJxeE9WKzIrT2I1ajVKYnZ3d2t6cUxROUJUQmVScGY1?=
 =?utf-8?B?cUE3dGsvNWRSVDdmcUlFbWlwdnd1bTJ3YmRGMDlBajVCRmo0Uk5heUg5Q0pU?=
 =?utf-8?B?VjluQmV3VkJRbGZWTUE2ekdWZ1VNeE1jVWJJZlMvQUpPNXl5cnM0THhHYUd5?=
 =?utf-8?B?ZmlBMElSbC9mSGViVDUvL2pHV1p3bTI3Uk9QTXJoZ1ZESGozZGd1dEFDQm10?=
 =?utf-8?B?VUxaRFVVRUdpRjQ0QlN2N1pzWmRlQlZCTFpEbzBqV0xqeml3QzJSV3VZcGpM?=
 =?utf-8?B?dHQwREY1NEk1N2N5Q0pUTEU4cVN5S1ppWnR3RGx6R3ZaRmxLdGxhYm9IREFT?=
 =?utf-8?B?OUwzby96blVjcHpUWFFXU2ZVZXlRRWl4UUtudGFiSktHSEsxSldFTitMQytz?=
 =?utf-8?B?K0t2Z2h0T1RESDVTdjFvaWo1SU1Gek9ZVkFRSWFsUjFWd3oydnVwVVl2S3RG?=
 =?utf-8?B?THV2dVdzam05MjdTUzZIbWt3VmMzYkxsMmpId3crbi96WkZRblFXMmNkVFhW?=
 =?utf-8?B?Y2dCanRsRHo3WUYrU0JFVGgrcmFScGg4cmtCUDBSMzJwVXFob1lMdUVQWnpm?=
 =?utf-8?B?dmpiZGdIcVZLNDFWRGRtL3UvM1d1RzRXdGxOYmFOb21ZYjdrM2tTbzBBVmVs?=
 =?utf-8?B?OVBQU3N1VTM4bmFWRHBCUWU2RDlCN0hWN3h0ZnFtU2ZsNk44M1pUUXRvOU8z?=
 =?utf-8?B?RzVUb3d4OCtBbGdXdG5hcXFreTFGSjNFQnBZQlJ1VTIyeTFLUzFnTStwQlF2?=
 =?utf-8?B?VjQrVTdUZEFoMW5HL3ZjRjhwVVBjSFhSai9GOWExOUtxK1JxbVVsYXQxQ1kv?=
 =?utf-8?B?T0gySS9YVUptTXV1ZXVTWk1sSHJvUUkwekJiUThPZTNyU2VBYWFBNk1nU0Rh?=
 =?utf-8?B?WmU0T1ZnM2d3enRIbERHMkd6OFkxWklYdGVJTHV1cmx0aXBYZnpOYXR1QWp4?=
 =?utf-8?B?ZWFhQmdBNWoxekZSTGJ6bEZoQXBpcUhQUWF4SHRrbjR0YmtzZ2FzUWFhTWR1?=
 =?utf-8?B?UHBrLzlyeXFTTXFVZWFjaGVPeS9Bc2VaVVRONnpDcnQ3azlGeUo2RlE1elpK?=
 =?utf-8?B?Vi96VW1lRjZiVDAxcGdncS9jaWxCS256QllpbkJPemw4UjJCazRjNDIxNHJB?=
 =?utf-8?B?bXZkREJPNUJzRyt3WWRERDJsTUhRYkl5YVJPRGFtRFJGM3UvZ1U0SlVpa1Rk?=
 =?utf-8?B?Y3RJN0dnQllkUTZ0V0x0dm84YnlxTDBwVk5BbU92cmlFS3FKK2ZnaFVldSt2?=
 =?utf-8?B?Qmt4ZlRxajFHWjFZK2NhNGJXZVJsOUVnN2tOck1NejlDSVRWOGJYYTFCcU9M?=
 =?utf-8?B?VUpNeWdiRDdiaUNseDhSeVVEWGZuaFlXc3VhWWM0WTcyQ2IxS1VvckFuWU9l?=
 =?utf-8?B?K2taTjFCUlBLaWtWeVVTTlZ4Y3FYUmx3YlBJYzgvZXNuQXRvY1B3ekJNKzFn?=
 =?utf-8?B?SHExY1JXUFVkdUFBNTZnUUhOVm5idDhRZFB5N1pwcXJlb2JUa25kWVBCVlB1?=
 =?utf-8?B?UWp4RS8wcUtRbEhQOW4rNG5vbFNjR2NESk16cFJXZ2NPSFNWa04zSGNkd2R1?=
 =?utf-8?B?eGlPK0NGMk9YTnEvMVNocTBpYVdrRHo4VGtuNWd4V1dtYjhnZ0hLOWZIM3Q3?=
 =?utf-8?B?ZlBZcnVuc2RTQnN4c1V4UENsdzlReFo2eTN5ZDErSmFzaUlRUk5wQUJHV3ho?=
 =?utf-8?B?RTAyS0phT1R6MGduSXB3d25iV1NyaU03NXh2aENteDZyWWQ2djIvT2c1SDA2?=
 =?utf-8?B?bmtDNE9iVng1WUkrRkF0RmExeERMVEhQZXhXNWszbld0Yi9NaW11Y2Q4TnZ2?=
 =?utf-8?B?R2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00B7FDFDDED41A4F9F13683860CE9B7A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cPtw6jwoYBddoEg67JoOncW+L9JjQQKloWpbh+HkT8fqnhk9IcBnRKNBYMNhpJXwgiwMYiO9plLS8rQpMa10kvQG37XL6YN6jiAnjv7wCvd7IQ3BQAJ4oT5yqBdgjynGxs9mf1H+pDEdTFA0UBhwj0LTZStpQtnhWMluijFSlNzZGh5MgSzh/54q95PCWc5jMkFkDmGaTxHWVOfGyHm3UA91RIDXrPU8gpFCvJERcVcWOe5l2Ewf4PVWddQTtJX0uwUMxLGsN7F1ErZGWDpXZU+M8OEqcsU3mYIgaL+CBQJMdxalweAcYQvBw2WJ0mZmpkR216xsqcXnYfv4GJL7qloiaaUR1IIDF6kzPQ1fE1+yjJdUMVOEiBrjcfybIzHuzozW710EIejDKvRQd3rr+2zrcZuh1QX8eBijS8eIl1E8Cl1SQdUw8MZRF4ZmeN96z++AY9e2U/uSkCPCjiFrfYF+UnZAikKr2znB35iSiviIvjulM1p2cha0X2Soc8Omon08Y15/mM+fQqcPPCF1AmWzV14vW4+ZGXjqrI/ejPG/EG20EnfQ6ryqRwJtCRJYYh4S5J1k/RA422f0uvCbrj7TcrF3nibearlML59Ipign+xLyrdIN8XAJh32UTcBxcrITzR4QEhYhkA+bQWdwvsJabup2RPz9DAnAAb/fmitFMMfaMaI6OXgS7YLuIXZS2J3jqXYr+pE2N3e449cbbT3GBTdeEAOB1NmeCC3Ro+fcKMVWUzURofvYZxXeH8SIvd5xnJUUiE5WxdP9FOCPXZvAg0nfDoYvfa8J4G6ayIaZQghPr6W3dyPyKggTFWG8IJ+6WONArzkzL8FGVhQq9Kj7u2KysdSNNuTmY6ixQjwweOeMpwcRsheCkRdxCOEV
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10931.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c06393-3620-4fe4-1c07-08db3a2cc095
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 01:33:28.6438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LVhLYXGT7eZTgBPXcvqi0FO4MjoZGv78Rb0oE7h9Zy5+zWHH18m1q/03uQ4MEog7xwN0BNHiFlknLrb4L7573w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10330
X-Spam-Status: No, score=-5.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDEwLzA0LzIwMjMgMjE6MTMsIEd1b3FpbmcgSmlhbmcgd3JvdGU6DQo+IA0KPiANCj4g
T24gNC8xMC8yMyAxNDo0MywgTGkgWmhpamlhbiB3cm90ZToNCj4+IEN1cnJlbnRseSwgY29uIHdp
bGwgYmUgZGVzdHJveWVkIHdoZW4gd2FpdF9ldmVudF9pbnRlcnJ1cHRpYmxlX3RpbWVvdXQoKQ0K
Pj4gcmV0dXJucyBFUkVTVEFSVFNZUy4gQnV0IHRoZSBpbi1mbGlnaHQgZXZlbnQgaGFuZGxlcg0K
Pj4gcnRyc19jbHRfcmRtYV9jbV9oYW5kbGVyKCkgY291bGQgYmUgcmVzY2hlZHVsZWQvd2FrZXVw
IHdoaWNoDQo+PiBtYXkgY2F1c2UgYSB1c2UtYWZ0ZXItZnJlZS4NCj4+DQo+PiDCoMKgwqDCoCBX
QVJOSU5HOiBDUFU6IDAgUElEOiAxNDc2NiBhdCBkcml2ZXJzL2luZmluaWJhbmQvdWxwL3J0cnMv
cnRycy1jbHQuYzoxNjg3IHJ0cnNfY2x0X3JkbWFfY21faGFuZGxlcisweDYyMC8weDY0MCBbcnRy
c19jbGllbnRdDQo+PiDCoMKgwqDCoMKgIE1vZHVsZXMgbGlua2VkIGluOiBybmJkX2NsaWVudCBy
dHJzX2NsaWVudCBydHJzX2NvcmUgcmRtYV9jbSBpd19jbSBpYl9jbSByZG1hX3J4ZSBpYl91dmVy
YnMgaWJfY29yZSBsaWJpc2NzaSBzY3NpX3RyYW5zcG9ydF9pc2NzaSBjcmMzMl9nZW5lcmljIHVk
cF90dW5uZWwgZGF4X3BtZW0gbmRfcG1lbSBuZF9idHQgdmlydGlvZnMgY3JjMzJjX2ludGVsIG52
bWUgZnVzZSBudm1lX2NvcmUgbmZpdA0KPj4gbGlibnZkaW1tIGRtX211bHRpcGF0aCBzY3NpX2Ro
X3JkYWMgc2NzaV9kaF9lbWMgc2NzaV9kaF9hbHVhIGRtX21pcnJvciBkbV9yZWdpb25faGFzaCBk
bV9sb2cgZG1fbW9kIFtsYXN0IHVubG9hZGVkOiBpYl9jb3JlXQ0KPj4gwqDCoMKgwqDCoCBDUFU6
IDAgUElEOiAxNDc2NiBDb21tOiBrd29ya2VyL3UyOjMgS2R1bXA6IGxvYWRlZCBUYWludGVkOiBH
wqDCoMKgwqDCoMKgwqAgV8KgwqDCoMKgwqDCoMKgwqDCoCA2LjIuMC1yYzYtcm9jZS1mbHVzaCsg
IzU2DQo+PiDCoMKgwqDCoMKgIEhhcmR3YXJlIG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMgKGk0NDBG
WCArIFBJSVgsIDE5OTYpLCBCSU9TIHJlbC0xLjE2LjAtMC1nZDIzOTU1MmNlNzIyLXByZWJ1aWx0
LnFlbXUub3JnIDA0LzAxLzIwMTQNCj4+IMKgwqDCoMKgwqAgV29ya3F1ZXVlOiBpYl9hZGRyIHBy
b2Nlc3Nfb25lX3JlcSBbaWJfY29yZV0NCj4+IMKgwqDCoMKgwqAgUklQOiAwMDEwOnJ0cnNfY2x0
X3JkbWFfY21faGFuZGxlcisweDYyMC8weDY0MCBbcnRyc19jbGllbnRdDQo+PiDCoMKgwqDCoMKg
IENvZGU6IDAwIDBmIDg1IDVmIGZkIGZmIGZmIDRjIDhiIDIzIDQxIGJkIGY0IGZmIGZmIGZmIGU5
IDk1IGZiIGZmIGZmIDBmIDBiIDRjIDg5IGY3IDQxIGJkIGVhIGZmIGZmIGZmIGU4IDc1IGM4IDky
IGVjIGU5IDRiIGZmIGZmIGZmIDwwZj4gMGIgNGMgODkgZjcgNDEgYmQgZWEgZmYgZmYgZmYgZTgg
NjAgYzggOTIgZWMgZTkgMzYgZmYgZmYgZmYgZTgNCj4+IMKgwqDCoMKgwqAgUlNQOiAwMDE4OmZm
ZmZhNGVmNDFjZGJjNjAgRUZMQUdTOiAwMDAxMDI0Ng0KPj4gwqDCoMKgwqDCoCBSQVg6IDAwMDAw
MDAwMDAwMDAwMDAgUkJYOiBmZmZmOTM3MmMzOTRlNjAwIFJDWDogMDAwMDAwMDAwMDAwMDAwMQ0K
Pj4gwqDCoMKgwqDCoCBSRFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJOiAwMDAwMDAwMDAwMDAwMDAx
IFJESTogZmZmZmZmZmZhZDYzNDI3Nw0KPj4gwqDCoMKgwqDCoCBSQlA6IGZmZmZhNGVmNDFjZGJk
MDAgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDAwMDAwMQ0KPj4gwqDCoMKg
wqDCoCBSMTA6IDAwMDAwMDAwMDAwMDNmZjMgUjExOiAwMDAwMDAwMDAwMDAwMDAwIFIxMjogZmZm
ZjkzNzJjMzE2NDgwMA0KPj4gwqDCoMKgwqDCoCBSMTM6IGZmZmY5MzcyYzMxNjQ4MDAgUjE0OiBm
ZmZmOTM3MmMzOTRlNjQwIFIxNTogZmZmZjkzNzJjNTIxOTAyMA0KPj4gwqDCoMKgwqDCoCBGUzrC
oCAwMDAwMDAwMDAwMDAwMDAwKDAwMDApIEdTOmZmZmY5MzcyZmJjMDAwMDAoMDAwMCkga25sR1M6
MDAwMDAwMDAwMDAwMDAwMA0KPj4gwqDCoMKgwqDCoCBDUzrCoCAwMDEwIERTOiAwMDAwIEVTOiAw
MDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0KPj4gwqDCoMKgwqDCoCBDUjI6IDAwMDA3ZjM1YmI3
ZDVkZTAgQ1IzOiAwMDAwMDAwMDIwYzJhMDA2IENSNDogMDAwMDAwMDAwMDE3MDZmMA0KPj4gwqDC
oMKgwqDCoCBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAwIERSMjog
MDAwMDAwMDAwMDAwMDAwMA0KPj4gwqDCoMKgwqDCoCBEUjM6IDAwMDAwMDAwMDAwMDAwMDAgRFI2
OiAwMDAwMDAwMGZmZmUwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQwMA0KPj4gwqDCoMKgwqDCoCBD
YWxsIFRyYWNlOg0KPj4gwqDCoMKgwqDCoMKgIDxUQVNLPg0KPj4gwqDCoMKgwqDCoMKgID8gbWFy
a19oZWxkX2xvY2tzKzB4NDkvMHg4MA0KPj4gwqDCoMKgwqDCoMKgID8gbG9ja19pc19oZWxkX3R5
cGUrMHhkNy8weDEzMA0KPj4gwqDCoMKgwqDCoMKgID8gY21hX2NtX2V2ZW50X2hhbmRsZXIrMHg0
OS8weDIwMCBbcmRtYV9jbV0NCj4+IMKgwqDCoMKgwqDCoCBjbWFfY21fZXZlbnRfaGFuZGxlcisw
eDQ5LzB4MjAwIFtyZG1hX2NtXQ0KPj4gwqDCoMKgwqDCoMKgIGFkZHJfaGFuZGxlcisweGYxLzB4
MWUwIFtyZG1hX2NtXQ0KPj4gwqDCoMKgwqDCoMKgID8gbG9ja19hY3F1aXJlKzB4Y2EvMHgyZjAN
Cj4+IMKgwqDCoMKgwqDCoCA/IGxvY2tfYWNxdWlyZSsweGRhLzB4MmYwDQo+PiDCoMKgwqDCoMKg
wqAgcHJvY2Vzc19vbmVfcmVxKzB4NDMvMHgxNzAgW2liX2NvcmVdDQo+PiDCoMKgwqDCoMKgwqAg
cHJvY2Vzc19vbmVfd29yaysweDI3NC8weDU5MA0KPj4gwqDCoMKgwqDCoMKgIHdvcmtlcl90aHJl
YWQrMHg0Zi8weDNkMA0KPj4gwqDCoMKgwqDCoMKgID8gX19wZnhfd29ya2VyX3RocmVhZCsweDEw
LzB4MTANCj4+IMKgwqDCoMKgwqDCoCBrdGhyZWFkKzB4ZTcvMHgxMTANCj4+IMKgwqDCoMKgwqDC
oCA/IF9fcGZ4X2t0aHJlYWQrMHgxMC8weDEwDQo+PiDCoMKgwqDCoMKgwqAgcmV0X2Zyb21fZm9y
aysweDJjLzB4NTANCj4+IMKgwqDCoMKgwqDCoCA8L1RBU0s+DQo+PiDCoMKgwqDCoMKgIGlycSBl
dmVudCBzdGFtcDogMTQzMjY2OQ0KPj4gwqDCoMKgwqDCoCBoYXJkaXJxcyBsYXN0wqAgZW5hYmxl
ZCBhdCAoMTQzMjY4Myk6IFs8ZmZmZmZmZmZhYzUwOGViMj5dIF9fdXBfY29uc29sZV9zZW0rMHg1
Mi8weDYwDQo+PiDCoMKgwqDCoMKgIGhhcmRpcnFzIGxhc3QgZGlzYWJsZWQgYXQgKDE0MzI2OTgp
OiBbPGZmZmZmZmZmYWM1MDhlOTc+XSBfX3VwX2NvbnNvbGVfc2VtKzB4MzcvMHg2MA0KPj4gwqDC
oMKgwqDCoCBzb2Z0aXJxcyBsYXN0wqAgZW5hYmxlZCBhdCAoMTQzMjUxOCk6IFs8ZmZmZmZmZmZh
YzQ4Yzk4NT5dIF9faXJxX2V4aXRfcmN1KzB4YzUvMHgxMjANCj4+IMKgwqDCoMKgwqAgc29mdGly
cXMgbGFzdCBkaXNhYmxlZCBhdCAoMTQzMjUwOSk6IFs8ZmZmZmZmZmZhYzQ4Yzk4NT5dIF9faXJx
X2V4aXRfcmN1KzB4YzUvMHgxMjANCj4+IMKgwqDCoMKgwqAgLS0tWyBlbmQgdHJhY2UgMDAwMDAw
MDAwMDAwMDAwMCBdLS0tDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlq
aWFuQGZ1aml0c3UuY29tPg0KPj4gLS0tDQo+PiDCoCBkcml2ZXJzL2luZmluaWJhbmQvdWxwL3J0
cnMvcnRycy1jbHQuYyB8IDE0ICsrKysrKysrKystLS0tDQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwg
MTAgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9pbmZpbmliYW5kL3VscC9ydHJzL3J0cnMtY2x0LmMgYi9kcml2ZXJzL2luZmluaWJhbmQv
dWxwL3J0cnMvcnRycy1jbHQuYw0KPj4gaW5kZXggNGM4ZjQyZTQ2ZTJmLi43NjBhN2ViNTEyOTcg
MTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvdWxwL3J0cnMvcnRycy1jbHQuYw0K
Pj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3VscC9ydHJzL3J0cnMtY2x0LmMNCj4+IEBAIC0y
MDc0LDYgKzIwNzQsNyBAQCBzdGF0aWMgaW50IGNyZWF0ZV9jbShzdHJ1Y3QgcnRyc19jbHRfY29u
ICpjb24pDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcnRyc19lcnIocywgIkZhaWxlZCB0byByZXNv
bHZlIGFkZHJlc3MsIGVycjogJWRcbiIsIGVycik7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290
byBkZXN0cm95X2NtOw0KPj4gwqDCoMKgwqDCoCB9DQo+PiArYWdhaW46DQo+PiDCoMKgwqDCoMKg
IC8qDQo+PiDCoMKgwqDCoMKgwqAgKiBDb21iaW5lIGNvbm5lY3Rpb24gc3RhdHVzIGFuZCBzZXNz
aW9uIGV2ZW50cy4gVGhpcyBpcyBuZWVkZWQNCj4+IMKgwqDCoMKgwqDCoCAqIGZvciB3YWl0aW5n
IHR3byBwb3NzaWJsZSBjYXNlczogY21fZXJyIGhhcyBzb21ldGhpbmcgbWVhbmluZ2Z1bA0KPj4g
QEAgLTIwODMsMTAgKzIwODQsMTUgQEAgc3RhdGljIGludCBjcmVhdGVfY20oc3RydWN0IHJ0cnNf
Y2x0X2NvbiAqY29uKQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2x0X3BhdGgtPnN0
YXRlX3dxLA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uLT5jbV9lcnIgfHwgY2x0
X3BhdGgtPnN0YXRlICE9IFJUUlNfQ0xUX0NPTk5FQ1RJTkcsDQo+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBtc2Vjc190b19qaWZmaWVzKFJUUlNfQ09OTkVDVF9USU1FT1VUX01TKSk7DQo+
PiAtwqDCoMKgIGlmIChlcnIgPT0gMCB8fCBlcnIgPT0gLUVSRVNUQVJUU1lTKSB7DQo+PiAtwqDC
oMKgwqDCoMKgwqAgaWYgKGVyciA9PSAwKQ0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJy
ID0gLUVUSU1FRE9VVDsNCj4+IC3CoMKgwqDCoMKgwqDCoCAvKiBUaW1lZG91dCBvciBpbnRlcnJ1
cHRlZCAqLw0KPj4gK8KgwqDCoCBpZiAoZXJyID09IC1FUkVTVEFSVFNZUykgew0KPj4gK8KgwqDC
oMKgwqDCoMKgIC8qIGludGVycnVwdGVkLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqAgKiB0cnkgYWdh
aW4gdG8gYXZvaWQgdGhlIGluLWZsaWdodCBydHJzX2NsdF9yZG1hX2NtX2hhbmRsZXIoKQ0KPj4g
K8KgwqDCoMKgwqDCoMKgwqAgKiBnZXR0aW5nIGEgdXNlLWFmdGVyLWZyZWUNCj4+ICvCoMKgwqDC
oMKgwqDCoMKgICovDQo+PiArwqDCoMKgwqDCoMKgwqAgZ290byBhZ2FpbjsNCj4+ICvCoMKgwqAg
fSBlbHNlIGlmIChlcnIgPT0gMCkgew0KPj4gK8KgwqDCoMKgwqDCoMKgIGVyciA9IC1FVElNRURP
VVQ7DQo+PiArwqDCoMKgwqDCoMKgwqAgLyogVGltZWRvdXQgKi8NCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCBnb3RvIGVycnI7DQo+PiDCoMKgwqDCoMKgIH0NCj4gDQo+IENhbiBldmVudCBoYW5kbGVy
IHN0aWxsIGJlIHRyaWdnZXJlZCBpbiBjYXNlIG9mIHRpbWVvdXQ/DQoNCkkgaGF2ZSBuZXZlciBo
aXQgc3VjaCByYWNlLg0KDQo+IA0KPiBBbmQgSSBndWVzcyBlaXRoZXIgc3RvcF9jbSAtPiByZG1h
X2Rpc2Nvbm5lY3Qgb3IgZGVzdHJveV9jbSAtPiByZG1hX2Rlc3Ryb3lfaWQNCj4gc2hvdWxkIHBy
ZXZlbnQgdGhpcyBraW5kIG9mIHJhY3kgaXNzdWUuDQoNCkluIHByYWN0aWNlLCB0aGV5IGFyZSBw
b3NzaWJsZSB0aGF0IHJ0cnNfY2x0X3JkbWFfY21faGFuZGxlcigpIGlzIGluLWZsaWdodCBkdXJp
bmcNCidlaXRoZXIgc3RvcF9jbSAtPiByZG1hX2Rpc2Nvbm5lY3Qgb3IgZGVzdHJveV9jbSAtPiBy
ZG1hX2Rlc3Ryb3lfaWQnLiBydHJzX2NsdF9yZG1hX2NtX2hhbmRsZXIoKSBhbmQNCmNtJ3MgY2xl
YW51cCBwYXRoIG5lZWQgdG8gaG9sZCBtdXRleF9sb2NrKCZjb24tPmNvbl9tdXRleCksIG9uY2Ug
Y20ncyBjbGVhbnVwIHBhdGggZ2V0IHRoaXMgbG9jayBmaXJzdA0KcnRyc19jbHRfcmRtYV9jbV9o
YW5kbGVyIGhhcyB0byBzbGVlcCwgd2hlbiBydHJzX2NsdF9yZG1hX2NtX2hhbmRsZXIgaXMgd2Fr
ZXVwIGFnYWluLCBzb21lIHJlc291cmNlcyBoYXMgYmVlbg0KZnJlZWQgYnkgY20ncyBjbGVhbnVw
IHBhdGguDQoNClRoYW5rcw0KDQo+IA0KPiBUaGFua3MsDQo+IEd1b3Fpbmc=
