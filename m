Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E3A68B865
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Feb 2023 10:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjBFJPm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Feb 2023 04:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjBFJPl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Feb 2023 04:15:41 -0500
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0929EEC
        for <linux-rdma@vger.kernel.org>; Mon,  6 Feb 2023 01:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1675674942; x=1707210942;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LZKWCnO1KEP7dUup+7GDe6GJGtRDa5cYxGqZg1Cy+0I=;
  b=SZHimexCwf4vf7rfK/cNxsQbj0T1tP+/Z8BrNf7iege+PpRHdMtbYzgf
   4KtqWS7foAU6/yYLzVcpZYsrsjKV2E9T4ufz1i/d0Z7iv4TWEqV3+897/
   nexwXxmHK6aZqJgHmuOHHYYLMD0B8C2o+CbMLIHr5LN6ZkkTerVr8jAC9
   EBqwepBWz+qcFqW5HY9cBIa/vhMJnmr0S/yLfkikT7RoukgD+r12naZC1
   Bns9gejq9HHmEQ/3P/TYBsdEZpwW4iGk3bRBjfUrR3A5E4tR/of9vEWND
   2p4uwLhVCNp8zc13KG9waJ293ZqH6yGh1KCAZvr/oCnfzTfLv15stCzao
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="76276301"
X-IronPort-AV: E=Sophos;i="5.97,276,1669042800"; 
   d="scan'208";a="76276301"
Received: from mail-sgaapc01lp2108.outbound.protection.outlook.com (HELO APC01-SG2-obe.outbound.protection.outlook.com) ([104.47.26.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 18:08:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgJXCKvb/PgGXG0bR3DowZogGz9YVbt2tlu0p9taD+kG2h9qiKT9A3X1G9+H8llJtrLS865EadUzLYa0FbV9PPW+ZY/F9fpLtW0Ei4AEcYSU8i62YCfp5DAEjY1uBVFydghiUfPPiNz8CccULX+d3KvshztZPOL61BRvwc464xErsgpVEQU5ONq2L3QBDIJ+qkdSWGvVnwEC7Rtl0SbGv44aTajxblfwxRovPA/hWt0LWE0ZoqKZ5DlKipVvyl4oS6YXY8cvM+XljmBllKi3zxBeBcyJNPPHDenlzunrdLLlFjmEX8+OQoYDadttUklGqfnCMo/8WNPK0z20DK1T1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeS45xmu+VUcdEToyY4dwMqaRfY0NnEBIWblsZ+kJng=;
 b=ib8RwYp0FA3M1/Q775qtkSNLz6YTHm7PUVx8kl7Ayd3E+FF8lOiGFHgqBSEt/vf69MppqN6Zs6SeDuOrGxDzLEzAjrgHMlHT1HbONzbXju7t7wiF/c7zU9yrVlLdRI6dTmhom0x5UDd+LInd9w978Ldqnz25N0RZAGOf5XPQBpAWBuLs1U+pTeZwASi22Vj8YOUKA+74KWOKAokeBSJULcS2zXWSqfiLZsNJphCmEIwDLPDagg28FksOtBAghIHglL1VRCRr8j3br+m13z4aQQ0QgwEUGITx3i/zMDfrzwMSaUd4r5GqUMBXFJUq6QVLVUPHkkeLoZFcUNPrcyw1oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by OS3PR01MB5704.jpnprd01.prod.outlook.com (2603:1096:604:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 09:08:06 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::4323:2aa5:fe7c:6a3]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::4323:2aa5:fe7c:6a3%4]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 09:08:06 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Deming Wang' <wangdeming@inspur.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/restrack: Correct spelling
Thread-Topic: [PATCH] RDMA/restrack: Correct spelling
Thread-Index: AQHZOgk/Fg72hCZXAk+IjyMkUNlVza7BnzYg
Date:   Mon, 6 Feb 2023 09:08:06 +0000
Message-ID: <TYCPR01MB84550C2753CC434A4A3A48ADE5DA9@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20230206085725.1507-1-wangdeming@inspur.com>
In-Reply-To: <20230206085725.1507-1-wangdeming@inspur.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: f6e5eca8fb6242c6bd83e7abdf0c4f22
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-02-06T09:08:02Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=c8efb436-8689-4bbb-9053-64a4bd180203;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|OS3PR01MB5704:EE_
x-ms-office365-filtering-correlation-id: df8f300b-389b-4209-5f1e-08db0821a8d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ONQdV2IHovLocAh8gie/dIf1zO6w2sCkNnWgCQkoT2RP4NC0XB22m54jMFCF0ACUZRPAgNSnHTle9UebudgUKvVLKzF7Wywt3m1W4BQkMtKW2JWrpBji+SwAGKgZdxFppXSDx4vF/uLR4LDLOx7lKi5dGlZJEM4bjluUxxt2K3snfIBEH3Ulk+dCQSk0DURPDRUtQAzThVlzymJxE7x+fZLDgMrCWFefWUp8vrQKVxnKKcMJW6e+H81RrZxvoi6QTvl6MUEXV3TN5ytN/lJEm2TAPv56fTjVwP5f6aq1SknnqRLlOmuglDmej4y7YfJfSQZjkgOulZx1SHBIz8d1YA/aFMwz+czatdr0agVgq4dJyxqdvfZe7pENJBnxs7KUB/aXp+ejNP7fgV8r3s6P7b4vXfZ0O3SSwyYEGnR6DxaFzbpiLgNypIuLeIqaHfJrxlgoKqPQ2nEMtj4DCaXyQfnuhuB6TInsRUcUT6LGIM18CvMAKH/M6TEe4B2W20dWwjpNW+sAtIGJ+c0hm/4jd4Vihv2afR6S72XX3Y48Fngo8+1SmqGwIm2ObNTH6QfQqt0iW8MUbM7xHrr+4LW5WYVTt2RpMB1L15qOasu3UDUYkn2JaL6LJwJdXrNBPsH4pgLNPBr1iLhLtWwqUHxuWpmuip3feO2eCzlcH4OERgn1puw24cc+74ccKjScQ+62FQrTRhm/c5KY4o4rwKpjLqnBdkcd/cySS/1liyuXZbo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(1590799015)(451199018)(71200400001)(54906003)(316002)(7696005)(478600001)(110136005)(6506007)(4744005)(53546011)(52536014)(26005)(186003)(9686003)(85182001)(5660300002)(33656002)(86362001)(82960400001)(122000001)(38100700002)(55016003)(38070700005)(83380400001)(66946007)(76116006)(4326008)(8676002)(2906002)(1580799012)(64756008)(66556008)(66476007)(41300700001)(8936002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?N25kU1RveWZDTEs1SGJUblBtdjZ5U1JYWWU4QlFpVWdXSDdmUXFTVSt5?=
 =?iso-2022-jp?B?ZGRPUklVa2JEeWlieUZhN3RqTE5zKzFwRGUzVUhIblFKUGVoSlNSYU1K?=
 =?iso-2022-jp?B?K2xJRDBDZG9PZ3VNY3o4dFR4UE05WHZ4L2E4bldvWEtaL2FUN0UrQnM1?=
 =?iso-2022-jp?B?a2JJdVVBNlZMYitqQk5ETlpaN1grZ3ZjVmc5Q2VaOElZaGJ4L3NEQk84?=
 =?iso-2022-jp?B?c3kwUGVPZElxLzZzc0x6T1hVY204QXZBdXdpSnZWdlJYSFY1ckxHbGxl?=
 =?iso-2022-jp?B?SWNVOFVYTS9KZGNMMVJDQmlmUS9vQlVzMmV0aWZraVdYTnVnQjMwT1hR?=
 =?iso-2022-jp?B?UndxbjVjWW9HOGRoUWZkUkhoUHhiR25FeWNtWXlDV0lTR1BtOTkvdDBG?=
 =?iso-2022-jp?B?VnZZVEs0RFcxQ0ZJcERPZE9PcTFQcjY5eFgyWVpVUUlDbUVJTE1BdGxu?=
 =?iso-2022-jp?B?cDcxeTd6K1FBbExLOHVrZUtWWFFMQWxpTEI3U2RRVEVrVXI5MnNzRzF6?=
 =?iso-2022-jp?B?ZEFsanRsMXV0RDZXMDhKZkppVXl6RkVkZ1NJam9pYTQyS2F0eW5EYkNQ?=
 =?iso-2022-jp?B?cENrdUx4UFJpTjJpc1BLd2VGazZ6VWg2Mlg3YnJ5UVlFcVYvQUhubVI5?=
 =?iso-2022-jp?B?M0liZHpYcnk5cjlpOVJDcVlmNU1CeVJOWUNuS0wxTHFBa0s5ZlZuQUZt?=
 =?iso-2022-jp?B?QklGWEphUmFaSnduNHhsQTE2MmJXd0JrVUJWTWVKcTZlZVJwbnloV1pk?=
 =?iso-2022-jp?B?VkV2eWY4UDU1SEVSSzc5YThJbmhSUWZmbmtjdzArRzA3Tnd1R2V6OGVG?=
 =?iso-2022-jp?B?NnhONEwxMzJTcUMvVnQ0aXI1U2o0dlFSaWp0MTUvVEFzcUtXSGh2SDV1?=
 =?iso-2022-jp?B?MUpIZmJZc0tuR1AwUGNCUmU2cGFNeXRoaURsTmZaNHRBRmd6SHU0WnpF?=
 =?iso-2022-jp?B?YWlYM09nWTJTWW9nTDY3VzQ1Z2szeE8zY2FWeXFObmRhRmxTL2RocU00?=
 =?iso-2022-jp?B?dHRtK3I4Z0xiUzZjbVQ4ell5TnFKNjV2dVpFSFRjZjFzZXMvejZQd25X?=
 =?iso-2022-jp?B?VkJ3K2RRUkprS2FZT0F3TitmQTBoZ3VmeGhCckZBanBGRkJTMEE3ZFpF?=
 =?iso-2022-jp?B?Nm8yK2llNE84SWlDUzJrU3AyS1l1cUVoaDEwU2xlZFc5U2lOZmJBY243?=
 =?iso-2022-jp?B?dTVWaUdlTG1vOEY5c2NGbHg4SjNraW1OU1dmSmUyMHZnbDZ6SzFvVzlS?=
 =?iso-2022-jp?B?SXdRWVZUaEkzQXVPRFEvTkRnY3l2V1RjWWN2OUlZWCswdkd5VEdwd1N4?=
 =?iso-2022-jp?B?a25oZUlnTXplZmM0KzR4SjliTXlSZ3dtS2pxNzdJZDJ3VTBUQ0NYazdy?=
 =?iso-2022-jp?B?b3BJOVZQckYxek9wcGk0UEY5YVNZMDd2MGU0bEZLSkdxSnhESTZwVkJW?=
 =?iso-2022-jp?B?S3hmYkw0TkFhbStpMzUzR0ViWXplcTlacDVITUs1K0hpMFkwVFFaSDJp?=
 =?iso-2022-jp?B?ZWJNcnhpaURSNHZqQ1VUVys3MWp0dmZHY050VVB6WWQvSGxGM284YTh3?=
 =?iso-2022-jp?B?WHVMQ29MK3JKbTJHdm5sU1BoTDhyYVViT2x5ckxnMFpLUXdPd1hiK20r?=
 =?iso-2022-jp?B?eG1jaGVzV1YzMWR0SThEQ0tqMUZCMVQrcFE2NnpKTFdDWHdJVDBaaE40?=
 =?iso-2022-jp?B?MHhRRWhTZjdIVUlVenBjUjNlOWo2ZStUNndpODRhaEg3TmRZNHkvc1E4?=
 =?iso-2022-jp?B?ZFZMZUNUb1E5Qit2S3d1VVdOV1BFdDFUcW5GY2FCODhBNkNDYWZ6bzdV?=
 =?iso-2022-jp?B?SWt4c3UyZUh1RU5zOUVVMEp2VUJaajg3Z3hqV1dWd1JDbUp6S28zK2NB?=
 =?iso-2022-jp?B?aG9ueGJsSFowbzV3NWhyMU5qY0hDN0pyc0FZUjhPck1oOHVLY2JlL2o3?=
 =?iso-2022-jp?B?ZldoR1hzeTdMbnczd2Q0eTEzVkwxdiswdDJIbkE4NHpESkxqbkk3ZE9W?=
 =?iso-2022-jp?B?a3hyQVM5YXkyc1ZmbUJnRnpESHBWcXp6ZUpzRlNVY3BSaVZac3FVTUVZ?=
 =?iso-2022-jp?B?amlFMHRURUVFd01VVlBBTXJndUd0eElJbmNhMXJ0UzZrUGlqamlYbHNE?=
 =?iso-2022-jp?B?a1pjQlI1cEhvTjQ5NysySFVTbGRIeFZENVlFblZxQmR5ZDR1bHI5MDZs?=
 =?iso-2022-jp?B?VWI4UDV6c1o2VlFjZ2IrNURtdnY0RWJQNVc4MmFuNmJYbTcvZ3VFOWsw?=
 =?iso-2022-jp?B?S3drdENienVFU2RjdWJwZmJqeHRUQUF0OCsyOEQyaDh2aFRGTlNUNW9y?=
 =?iso-2022-jp?B?TXVtTGxuS1o1aGtHNk83RWRaSFdQWklJUVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AzH7/gAZKH95gFBu+8sbQ1B5eKMa0jAfobaM9SnVfLf4vsdbK3sdxQ+pQrYpRRZyTqmFiliZODVS3Vv+UqdWZEdGDgfjwz+hxGyHD3jHFch7ZC7U+5DwJNtlceRMCzHHEksEcL3rCOS9C2IjebNSoVqDJIORqYSH5dSIHS9C3RfTAkP9d7KXAAnYuv+QGu092UlN/MHdAUMU3zLbDGBdJisPrYbpNOFAAT8WDk5Xf84VqKlJqR4RB/y9fkTTClNoSNQhk73df432wKtC7pNnTsMuSgrcckgLd4ntPyvKlqdsopTTeMnZZCA8Z8uoqnm1gHrWumCnim+uJA5rfOhpTyCCilkOPvesnn+8aBZgwYAm8I/MD+WufuasUjumMmTACiXGzDCsBXQRXDvR8KrKIjmVmXBzxO+ar8UvR8vwo54FJMbreNdlQl0IojADQsNDr/9Qd7JmQebbN0lHghxw5tP0NAy7lEHS/ryNmxn/uVwnOpU/aY3omL7RYUS88/7V4UO92zc/UDLLMtJH91NfQMTJbC9iq6Vjm2pPzaWhN7KIIukwQtH966ja2Yx7rBZNufa2iMH9A9YVTHSGIixks3uowaLSH3CvjbMz0l2HaUAPvDAaa5IAHRw+W0AmikS3X0wvICuGZ4ApKhtKu129mXOfOanjXTJCzLH6pMC9ai7ydewR1FfaxQ9lpUbqf2yaFr6pQ9u7jlhNu9ggQD65KkoeGuQ3SnP5RTZZ+A61QtDv4P11OkJj91yXIVgIK/vYLvOKGreT/9l6TcKZ0uKK9OyuNJSURmqUnnh66dLy6IQsnv5kWQ4v+A/IYYPq8fjA1WEkWhhboRBnKquouZINFBZqufQrezBGmKNVRrc6xgg=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8f300b-389b-4209-5f1e-08db0821a8d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 09:08:06.1996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2+U7WX0hoiOVpqPbx/VppvhiAxvr+Rlx1nWmSAFz2mFJQ8AaO3tZEDXFkptnECAYyxLM0dOXjZPcqhPGlDxQe93beylldpOb9kB9/aW05fs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5704
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 6, 2023 5:57 PM Deming Wang wrote:
>=20
> We should use this replace thie.
>=20
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>  include/rdma/restrack.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
> index 79d109c47242..d7ee54b7b9ae 100644
> --- a/include/rdma/restrack.h
> +++ b/include/rdma/restrack.h
> @@ -162,7 +162,7 @@ struct rdma_restrack_entry *rdma_restrack_get_byid(st=
ruct ib_device *dev,
>   * rdma_restrack_no_track() - don't add resource to the DB
>   * @res: resource entry
>   *
> - * Every user of thie API should be cross examined.
> + * Every user of this API should be cross examined.
>   * Probaby you don't need to use this function.

'Probably' instead of 'Probaby', right?

Daisuke

>   */
>  static inline void rdma_restrack_no_track(struct rdma_restrack_entry *re=
s)
> --
> 2.27.0

