Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0751472AD80
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Jun 2023 18:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjFJQnz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 10 Jun 2023 12:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjFJQny (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 10 Jun 2023 12:43:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF241BE8
        for <linux-rdma@vger.kernel.org>; Sat, 10 Jun 2023 09:43:52 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35AFM5Fu018326;
        Sat, 10 Jun 2023 16:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=v7gdCLYASdUaVSsI75D7/i2s0ZKXE2usZDI3TJPEyg8=;
 b=yuGp9/XdTGhQ9t5jrXBDwxIpuxjIH6v6mK993JZYy6zsR1DAleT96PtwtTIz7V+9pOgt
 HFzb9g3LI/JMMlrPE4ahwHEETbDebBVE8sfHxQBDoo3LnRSIPrAuJ5QdavW/A9hjKHUQ
 C/1ldn8I5pZCzpfxSQB56WIAAY7ymDeIzRqb+M0D9izdoWG2+3qoRB8P2Y8pmkW1K9w2
 mcpLpKhQ5OXjMcbFpDF31GO7DtldBpZ4vaYUEOhFMaut+QqCXRy+EZl3gXSbO1ATEudu
 6wG0d66CyVyVbJKUc0Ow76jDS9i6QIgMMFCnQlCj/ANmR7pjAfB3FP4deCLf7deDltUT zg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4gstrken-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Jun 2023 16:43:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35AFamBN016326;
        Sat, 10 Jun 2023 16:43:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm1dde2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Jun 2023 16:43:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyJQu0c5cTaH1fecu9Bah94DAJYAQLRWkGmfN8N+fFn2GWs55zm7d+7L5HYpzSdUWhKAFH5rc1CzNlifZlJdWT93i7/MoluzkHZ/UMnjCl2KpK9f90QSH2hIm3+OFtpyNmlCl34AAJzA/gNiJfJvmCNQgpJLAH1OTOXaf269YazeHPzwwE3Qa1VYrSX7hlE/gu6ZYNsDo3jv0vh1K9EaLgkxR4JGBKr+typCjlX9/QDRh4JwCa7PigjsdbqHuMiSMlK5KuU2+aGZjuYJFdUB1zljBSveA6ZTY5WvVhnhlDqj7qv0Gtg7wSfY9LGorBuUijUIUt8OYFxhlmK+mwIXjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7gdCLYASdUaVSsI75D7/i2s0ZKXE2usZDI3TJPEyg8=;
 b=nxjm/QENkaYld62VkOPkTu7xJxonJvFyBg0cPkl/KyLbmUeMNUTAcJmjVDtmcTYdM6PjSs7uKhwuY2Z9Z1yGMSh2mtPAlXq3ZnLFKEkQbvvrUq3BaRPw1KsN+f29v4nSh5SlKubFH5cfzbMIgJioIyCU+J9nfQ9QPYK+PLB4QKqwqWe6vrusBm1JDc8ZRnzp1N+LilTDJCvi0p8J/OjVJfEFcGuUKJPQ60PzRbY7XoltnbRHjPjMgzKyAYRbZ8VVt2s10gWERFdu2BZbESdfnSWCxHVOShgDTzUyxi/5WogN3oLmMWyMcfrDpPFrQTgHpC3YOQZLj/9+/kTeQYLrsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7gdCLYASdUaVSsI75D7/i2s0ZKXE2usZDI3TJPEyg8=;
 b=S5rF980dQ1lwrNaDI9YCkqNDcjystg2bMDJTox6iPq0Wcw2XqQwgIHL5SfXJ4qJJvRDgVk7xd7lX8yHexFRm8N+TY9Z8bMqqaOLW/R1RFWX1TKZSBGjJQZ4PTkLWKAB6fJw/aa7AXHcOZBgiszaRn9t1ZrS3qvCarl7OfbUumaQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4406.namprd10.prod.outlook.com (2603:10b6:510:34::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Sat, 10 Jun
 2023 16:43:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 16:43:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
CC:     Tom Talpey <tom@talpey.com>, Chuck Lever <cel@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1] RDMA/core: Handle ARPHRD_NONE devices for iWARP
Thread-Topic: [PATCH v1] RDMA/core: Handle ARPHRD_NONE devices for iWARP
Thread-Index: AQHZmXhvzGSl24EZQkuCbGf5eLkl0a+C9OuAgAA2aACAARb/AA==
Date:   Sat, 10 Jun 2023 16:43:16 +0000
Message-ID: <81CAD740-E3A0-497C-A4AD-276B8B2FDB35@oracle.com>
References: <168616682205.2099.4473975057644323224.stgit@oracle-102.nfsv4bat.org>
 <dd9f65ab-d54f-7830-8043-57ea66c76149@talpey.com>
 <68b162e4-06a1-520d-f157-d655cffafb01@linux.dev>
In-Reply-To: <68b162e4-06a1-520d-f157-d655cffafb01@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4406:EE_
x-ms-office365-filtering-correlation-id: e5f004f9-123c-4c72-f021-08db69d1ca65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M5hTuE4UwBci/z/vHgOuI9DpZVtswqUv++eXeaa1coO382x+U8PstY4SAyoerVwB57X4BTjHLLWkxfasisAm1A/OwIAtBX8UR+0GPt9f5aFfy2Wb/urk7TN/KfqZvNY7CwJg/b66uDoTmDpzgdV1pY29rAkfIQlTjsdNmMZzaGS9H8Y50UoRpLpZiqY/ctMGQrFjNj6LDt+fvgyxPNyk+Bm+46VVeIs4ZnFqh/ORo++/ek2iLtnZ8HXUcJ9AlJomITCk6eEgh8+STgQx9hIrJmr3ibgQ/RIoZYC9Ks52X1E32RNI+jFtJN2aqVJvnDWVRTQw8NsdENIEEx04SrB9AgSd2vSIENiOUf/3iIClQgyCmH7HhQi9O8DCfrA1UgDQZxnKRq1xgJFQI5V4kGk39cN+XP3zkg1YQcLW7gim0+T9eSlXFXM5Nvpofs3/yMDcIQrriEG4cL6HAnRNxsTH4KAAcSEX0Xa2AR71pURV5AW2PBUoeeqhIAeX3cGkrXW/Q8Ejc8TLg+a7yPnrAorKodskgURODnc5cgcHMGY2REUaCzciyGZfRprZpjS2erK4jsof5ISm7k5I+ANMUbhptI/9ym3ENFXWTSrK74HLJw7UFhD5Drt1ptYaQJLVNF2kqqP/yME4GEv/ViUyLfG87Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199021)(316002)(6486002)(41300700001)(83380400001)(2616005)(86362001)(38070700005)(53546011)(6512007)(186003)(6506007)(26005)(2906002)(33656002)(122000001)(38100700002)(5660300002)(36756003)(8676002)(8936002)(66476007)(66556008)(76116006)(66946007)(91956017)(478600001)(54906003)(71200400001)(6916009)(64756008)(4326008)(66899021)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnIweGZyVzhBa05WdTN2dkhNb2JzUHNTNHE5VGZiM3dPdWxQcDdvS0R3aVhh?=
 =?utf-8?B?QVRSblFwUjNvM29TYTVIWTUyOWFkNVFPTnRzVEdSMkx5Vk8zMk11Nzlkck5k?=
 =?utf-8?B?R3Z1emVsNSt0RzRFcG1TUW9PZXhrUjNLZEcrcnh6VitMZnJqM0J1ZGFrVXRi?=
 =?utf-8?B?UzRvSnZuYkdtMTZFdi94MkFBNXBzY0R2ZThPZEdDbTRzT0dlTmczSVluSWdB?=
 =?utf-8?B?WlhhL1dZR1BSVDZVWktkUlJwaWc0VnpBL1FJcU5mUWZWYTBobmxHZllMc0dY?=
 =?utf-8?B?ZlVDbE8rc1NFcWxrQTdYa29LeE0yeEFEZWNFNGlpZ2UrREVtdWNYaC96WHdR?=
 =?utf-8?B?Q1UxRGtxZGlqQXFkekZSVWZXbnpaeVlGelJiQm9nVE16bEMyNUo2SldjblQx?=
 =?utf-8?B?aWROdndmeGhUaEJKV3ZaMkVzSWRKWjdxZVhNbXE5a3BzZmloeEp3dFNFTTla?=
 =?utf-8?B?WC9ZZlQxaktjSUNaRXNsK29hRGRLajBhUDcvcFpCVW9TUUZpeHNvMlJBVHc4?=
 =?utf-8?B?MlVYQWwzSG0rWVZyZDB0SDZDd1FHWmlSSkQ0TlRNN0R0WVFDN0ZzTDNlWTNv?=
 =?utf-8?B?eVphNTJrRUI1bVp5dkszVHU4ZmUwdW00aU02V3Z0c0NCNUdOV3pZVG8rOW5I?=
 =?utf-8?B?NnZCWlNmbitlNXNFYWl4d29PZERFRnFxUHc0cmhxbDNRU25JL1NTMklEUGlE?=
 =?utf-8?B?anN6Njd2K0VHOXFiMS9xU0syU241dTQ4eTBwWVlPdnh1cXVZb1grUGdwcm9w?=
 =?utf-8?B?VXlsaHd3V0t1NEdTbHBkUzdjQlk4M1c5SksvTUZOKy9TNytZMHlab3BXbHZw?=
 =?utf-8?B?bXhRd2IyNVJnczJ2dEJRQ1JZZnBKZEJ6K3FFQzgxLzdaaFptQkc2aG1HdGY1?=
 =?utf-8?B?M2crZ1d4UUpUNjN6cnE5dVhuSlYzY0JkdWZ0NDhHYnFVS3MwTGYwQW9FMUNr?=
 =?utf-8?B?QUk5MFduTVZRY3ExalNWd3l5MVU4bmdPNW9wS2FVaXJmei81ZGRrakQyME1l?=
 =?utf-8?B?d2xzNnp5cUI2ZHUzY0RvMnVRd1VPY2RRdGF3dTJYL3Y0bTlxNXF0bXRsMUpx?=
 =?utf-8?B?L1BtQmREc094RFh1YkZYRXNRSHAxQWtaeFcvNGJYbVhva1JmeXlXZ0diQ0pw?=
 =?utf-8?B?SmdOVkhPaVFLU3BrZUNiRUMyK0NLdlpCdTZwOFhwRXoybms4Y0gxeS9LVFB3?=
 =?utf-8?B?Mi9QeERSN2VUbWlqbmh3YzdKUCthSEowTjE2QWs1V2lrOHpyS294VVNGdDVK?=
 =?utf-8?B?MncreElyRG9VSWorWUZ6NVNUMStTV0JYb1JxZ3ppRVgrZzhCZ3pvdlBGUG1X?=
 =?utf-8?B?UitQTXFsQjgvUEFBaUFNaEI0ODVyVDhLcEVyektQbzg1NmdMNzBEdEdGNk1i?=
 =?utf-8?B?TTdOVnJ0d1FYMjgyUyt0ZHh1QmhuSkxMNW9zZXpLK3RkS0loaGFFa1ZkWFNH?=
 =?utf-8?B?VUgxbzdjSTMzRWFkUVhmUjNkYjE3YW9UM1NBOThmOG45dFVGclNtQWhSK2Vt?=
 =?utf-8?B?d0hxZU1IUThySHUzV2YxYXdtUEFqZlNuRGx3bk9vaHU5dm9PV2w4ZXdFTHJD?=
 =?utf-8?B?L3V1UzAwSGIyYkgzNXdHZTNyRDNIVG9hUENUMFZKOURyUXp5eFN5TUVqdExB?=
 =?utf-8?B?dkpZQWVVM2Y3SmdnYUlyQlVQSlNJaG5xcUVrdmRuSFdRNzRNeHM3bk5LV1FL?=
 =?utf-8?B?MzhGN0p5WmsvQXRvVi93c0N3djRjb3k4MXh1NHBzS0ZpUkc4emJLSlJsaDJ3?=
 =?utf-8?B?Y1J5ZWlYV3pDbU4xTWpmejR1U0FMYVBpcXNJSmthaHZmbExtaVhuQk1wRFdh?=
 =?utf-8?B?Tml0WGhTWGJiV3JxeG10cksyNjJpOHZMUFZSN0FnS1lVQm52NFFKSUNoTkov?=
 =?utf-8?B?cVBjc254WFh6RnMyTDlTUk96V3h4djhiZUlaU0JKOHhFQ0ZWMXV1N1ZrbWtZ?=
 =?utf-8?B?a3dNcUVMSG4zY1JZazhialAzSkpndVZKZnVFQUhqUWpaeGt6ODlDdWJzeUwv?=
 =?utf-8?B?ZUNYUmpHRGJhSXFkZUlLb2lPMnJYL1c0eWJlRHpTTFFpNzJTRnltUytONWRp?=
 =?utf-8?B?WFBCY3VLNGZ0VlVrS3R1cWRIUW9nMStsQ3kxbWNOK2pwdW9sN2YrMHI5Wkgz?=
 =?utf-8?B?bzdaTHdzQ1JMaXJTQjNIZ3A4SnBaVmx0TmVIek0rWHc4Ky9rYlRHNEFPREtV?=
 =?utf-8?B?b2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <407F933D13C5CA4397082B50BF09037B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mIEwsfRguQwMhX5xQz3vIhgEc5TFUc20e2sNm0nUdAg8fSqRNOlJAftu/YA15riOeCrcH6sXyejmuOHvOvR1WaMWjaWo1nTGSvOvMgG4cVrEof4WyACYbFR3rHR99AsawuzcVrqf750fWKi+RpCJShvgdZdFAyGGUf9t5JSN8X9Y1YivHyW2CkEbtg86mKzQd/qXzP1Di8c+zUVuP2A6ZTjprALrZwWEV5+0mUeQlmlhWdo7xTE+8GOu+FjpUJHqU6zGAyR9Ryqr/u6lZOs/BhKHeKjpbGhlcugLyEtQtd/ceqN3CkywltGDJa2as1RZ4qMaCWumCjxHFIvt7dHju6u5khdYPX/T4V94V0vMhFSorczWT0L6uVty/FOgAijvPN8Y3wQSO25ro6VglrdyuAwPVguTD0q9YHiyf0Is07SqW8IvNccALw2nj0qpDmZ15H90qAf+RckbxndZ6LVhMfcQzJJOx3aXHDXnEpG3fO6SdQUDWfGlmyMmmlkyt3y4rMw9SqPIShF2IjcXyiv6S25WlSF/hYw0vjcE4IPIr910Uc9LdK2UmMmvMjvajZR92a6ecsO6rDlw8WxVU9MSx66yup2vIkfGeNUU2Pfnt/iRMNW8mhvYJVeUDVC6mjD/U4uWS2q4aBbLFCTLuGTK8BB2P7kqfhDB/4h7mhqXpbIls6dZWcSHUyImhBe58x3R9uPdoDZ3uLiDhPRj2YVdETsw5T48Pv8gTtLYUk0boE2kFumf6rL//xrlAUpKZQ0obYocqluh46P19noYQiBXy6L0Dp2Mz6eqeQho2BJRqdnaKkxr2juy9aJCHJ1yRuHn+OsLGgfShDyC1TnW+oot5Q7NJrOrF/QdRKtko2xFKUSV6qoLUMcqFuXKDx7He+TdtvKiEFepwZ8g7l3LnvtbA69OWHM/iuQ8OWLlIu5+q/A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f004f9-123c-4c72-f021-08db69d1ca65
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2023 16:43:16.7678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hAX/X+V/MrshNZOOuemXKTbCziLOLDmYM00MnFUtflDcZOQOCyOBMdhFgLgNux6RLSy225IvBwNpn/Z/IznFlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4406
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-10_12,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306100145
X-Proofpoint-GUID: HSVy4llAbjdoOntC1ETjOGq3VeYl9sXA
X-Proofpoint-ORIG-GUID: HSVy4llAbjdoOntC1ETjOGq3VeYl9sXA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gSnVuIDksIDIwMjMsIGF0IDg6MDQgUE0sIFpodSBZYW5qdW4gPHlhbmp1bi56aHVA
bGludXguZGV2PiB3cm90ZToNCj4gDQo+IOWcqCAyMDIzLzYvMTAgNDo0OSwgVG9tIFRhbHBleSDl
hpnpgZM6DQo+PiBPbiA2LzcvMjAyMyAzOjQzIFBNLCBDaHVjayBMZXZlciB3cm90ZToNCj4+PiBG
cm9tOiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4+PiANCj4+PiBXZSB3
b3VsZCBsaWtlIHRvIGVuYWJsZSB0aGUgdXNlIG9mIHNpdyBvbiB0b3Agb2YgYSBWUE4gdGhhdCBp
cw0KPj4+IGNvbnN0cnVjdGVkIGFuZCBtYW5hZ2VkIHZpYSBhIHR1biBkZXZpY2UuIFRoYXQgaGFz
bid0IHdvcmtlZCB1cA0KPj4+IHVudGlsIG5vdyBiZWNhdXNlIEFSUEhSRF9OT05FIGRldmljZXMg
KHN1Y2ggYXMgdHVuIGRldmljZXMpIGhhdmUNCj4+PiBubyBHSUQgZm9yIHRoZSBSRE1BL2NvcmUg
dG8gbG9vayB1cC4NCj4+PiANCj4+PiBCdXQgaXQgdHVybnMgb3V0IHRoYXQgdGhlIGVncmVzcyBk
ZXZpY2UgaGFzIGFscmVhZHkgYmVlbiBwaWNrZWQgZm9yDQo+Pj4gdXMuIGFkZHJfaGFuZGxlcigp
IGp1c3QgaGFzIHRvIGRvIHRoZSByaWdodCB0aGluZyB3aXRoIGl0Lg0KPj4+IA0KPj4+IFRlc3Rl
ZCB3aXRoIHNpdyBhbmQgcWVkciwgYm90aCBpbml0aWF0b3IgYW5kIHRhcmdldC4NCj4+PiANCj4+
PiBTdWdnZXN0ZWQtYnk6IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+DQo+Pj4gU2ln
bmVkLW9mZi1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+Pj4gLS0t
DQo+Pj4gICBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWEuYyB8ICAgIDMgKysrDQo+Pj4gICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+Pj4gDQo+Pj4gVGhpcyBvZiBjb3Vyc2Ug
bmVlZHMgYnJvYWRlciB0ZXN0aW5nLCBidXQgaXQgc2VlbXMgdG8gd29yaywgYW5kIGl0J3MNCj4+
PiBhIGxpdHRsZSBuaWNlciB0aGFuICJpZiAoZGV2X3R5cGUgPT0gQVJQSFJEX05PTkUpIi4NCj4+
PiANCj4+PiBPbmUgdGhpbmcgSSBkaXNjb3ZlcmVkIGlzIHRoYXQgdGhlIE5GUy9SRE1BIHNlcnZl
ciBpbXBsZW1lbnRhdGlvbg0KPj4+IGRvZXMgbm90IGRlYWwgYXQgYWxsIHdpdGggbW9yZSB0aGFu
IG9uZSBSRE1BIGRldmljZSBvbiB0aGUgc3lzdGVtLg0KPj4+IEkgd2lsbCBhZGRyZXNzIHRoYXQg
d2l0aCBhbiBpYl9jbGllbnQ7IFN1blJQQyBwYXRjaGVzIGZvcnRoY29taW5nLg0KPj4+IA0KPj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWEuYyBiL2RyaXZlcnMvaW5m
aW5pYmFuZC9jb3JlL2NtYS5jDQo+Pj4gaW5kZXggNTZlNTY4ZmNkMzJiLi5jOWEyYmRiNDllM2Mg
MTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hLmMNCj4+PiArKysg
Yi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWEuYw0KPj4+IEBAIC02OTQsNiArNjk0LDkgQEAg
Y21hX3ZhbGlkYXRlX3BvcnQoc3RydWN0IGliX2RldmljZSAqZGV2aWNlLCB1MzIgcG9ydCwNCj4+
PiAgICAgICBpZiAoIXJkbWFfZGV2X2FjY2Vzc19uZXRucyhkZXZpY2UsIGlkX3ByaXYtPmlkLnJv
dXRlLmFkZHIuZGV2X2FkZHIubmV0KSkNCj4+PiAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVO
T0RFVik7DQo+Pj4gKyAgICBpZiAocmRtYV9wcm90b2NvbF9pd2FycChkZXZpY2UsIHBvcnQpKQ0K
Pj4+ICsgICAgICAgIHJldHVybiByZG1hX2dldF9naWRfYXR0cihkZXZpY2UsIHBvcnQsIDApOw0K
Pj4gVGhpcyBtaWdodCB3b3JrLCBidXQgSSdtIHNrZXB0aWNhbCBvZiB0aGUgY29uZGl0aW9uYWwu
IFRoZXJlJ3Mgbm90aGluZw0KPj4gc3BlY2lhbCBhYm91dCBpV0FSUCB0aGF0IHNheXMgYSBHSUQg
c2hvdWxkIGNvbWUgZnJvbSB0aGUgb3V0Z29pbmcgZGV2aWNlDQo+PiBtYWMuIEFuZCwgb3RoZXIg
cHJvdG9jb2xzIHdpdGhvdXQgSUIgR0lEIGFkZHJlc3Npbmcgd29uJ3QgYmVuZWZpdC4NCg0KSGkg
Wmh1LCB0aGFua3MgZm9yIGhhdmluZyBhIGxvb2suDQoNCg0KPiBBZ3JlZSB3aXRoIHlvdS4gT3Ro
ZXIgcHJvdG9jb2xzLCBzdWNoIGFzIFJYRSwgYWxzbyBuZWVkIGJlIGhhbmRsZWQuDQo+IFNvIGEg
YmV0dGVyIHNvbHV0aW9uIHRoYW4gdGhpcyBuZWVkcy4NCg0KSSBhc3N1bWUgeW91IG1lYW4sIGlu
IHBhcnRpY3VsYXIsIFJvQ0V2MiB3aXRoIHJ4ZSBvbiBhIG5vbi1FdGhlcm5ldA0KZGV2aWNlPyBU
b20gYW5kIEkgZGlzY3Vzc2VkIHRoYXQgcG9zc2liaWxpdHkgcHJpdmF0ZWx5IHdoaWxlIEkNCmRl
dmVsb3BlZCB0aGlzIHBhdGNoLg0KDQpJIGRvIG5vdCBvYmplY3QgdG8gdGhhdCBpZGVhLiBCdXQg
SSB3b3VsZCBmZWVsIG1vcmUgY29tZm9ydGFibGUgaWYNCnRoYXQgd2FzIGp1c3RpZmllZCBhbmQg
dGVzdGVkIHZpYSBhIHNlcGFyYXRlIHBhdGNoLiBJIGV4cGVjdCB0aGF0DQp0aGUgbG9naWMgZm9y
IHRob3NlIGNhc2VzIHdpbGwgbG9vayBkaWZmZXJlbnQgdG8gd2hhdCBJJ20gYWRkaW5nIGhlcmUu
DQoNCg0KPiBaaHUgWWFuanVuDQo+IA0KPj4gV291bGRuJ3QgaXQgYmUgYmV0dGVyIHRvIGRldGVj
dCBhIG1pc3NpbmcgR0lELCBvciBpbmZlciB0aGUgbmVlZCBmcm9tDQo+PiBzb21lIG90aGVyIHRy
YW5zcG9ydCBhdHRyaWJ1dGU/DQo+PiBUb20uDQo+Pj4gKw0KPj4+ICAgICAgIGlmICgoZGV2X3R5
cGUgPT0gQVJQSFJEX0lORklOSUJBTkQpICYmICFyZG1hX3Byb3RvY29sX2liKGRldmljZSwgcG9y
dCkpDQo+Pj4gICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FTk9ERVYpOw0KDQoNCi0tDQpDaHVj
ayBMZXZlcg0KDQoNCg==
