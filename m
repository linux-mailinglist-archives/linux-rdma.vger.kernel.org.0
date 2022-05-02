Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABB9517594
	for <lists+linux-rdma@lfdr.de>; Mon,  2 May 2022 19:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243829AbiEBRTW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 May 2022 13:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386749AbiEBRTO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 May 2022 13:19:14 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970596593
        for <linux-rdma@vger.kernel.org>; Mon,  2 May 2022 10:15:43 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242Ccpjg030779;
        Mon, 2 May 2022 17:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=XuoeHIlkVN2Ui/ebpuO4usxJQmDEQ62MinrH6JES4nU=;
 b=A1+0U7g9pDRegzfVD8TFTBmvMrGKnodFpVN+Ur/ByGNKzKViEbRZDT1irVJ6CmhepsIs
 uh1uebLibjRInEZo/STYuRDMy9K9auqKzXkWG4iu51/WovzhbyJHRRnsFZDJAeGJW/9z
 QiUbu0gN4xDmLUS+mFk9kCpd9d1GWRipx3KuUbLktWgbMaK2y3s/KEFL9yccd769DskC
 gTDKRGHzyfxz22dcscbwcT9n/k3U3plTcsvGb5svD0hJhTDxSpwC69tqk2hpyO3VCziJ
 9d7sJpdSWW37J5EYQ2zxtpNRLAQJe5DgxJ/N0YPJeZntr6jPYEZAR/mKNY+oLBPkEayP rg== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fsu719dcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 17:15:22 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 56BCE1309B;
        Mon,  2 May 2022 17:15:21 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 2 May 2022 05:15:16 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 2 May 2022 05:15:16 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 2 May 2022 05:15:16 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9TneoHhIV6wK0iju2R1Qr+JDjhOSiLZHccOAHW7FQa/4Xhwulm4i+tYNQQ1FGFkCI8cjVTv2F9mS4njjJBNcq7ICC3e273tVtQUeeEUrdO69LLMQzGHT38W0KRPlLZVTFnc3y34ioOGl+McQPcoRABspdh57QH7ylPFlH2bIqLW703irDqJrmqGT5AWf4PqTJayKPHxAphPS3gCj37YP36SEU67Dh1rJTD6pCacrUdeCrwYbCvXXf5Gzm4GwBe8FpOdnMTG6oBoe4BA/wqqM41j4wqkFVBWe4z81avYFVKx+k53E27S3fxFil/kP7mCeDkR5js3x5SrrPDzUgX7CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuoeHIlkVN2Ui/ebpuO4usxJQmDEQ62MinrH6JES4nU=;
 b=Ghd4ZrvVSX2nAcunaWOsHfjxzqwmho5yhniaIKwi0iSC/lT7ajJjwaOQ7BeQgmYsAu+ZtA9znQKJNtvNA1Kcuq6HSjat9afjQAWZn2DUDsdkLQ1+/waBChyjc0HbkPq2pnatn/N1ZBI1+XAoJ/jFZTEE6Mn/CpzDROde9Y0QhQKzZghIMZE6EjAGtc9BtpiNG+pa54XDyLs6lFT7bSCtvcgmH6mgeSe4zJRDRIOnnlYMjhiEDDyaPWnkvzR0AXx7rE55AZBApV3dOtaaUwFZVYrR3FLgvIIFdw2CREcuh+n7ijpyskyJBpnHoSksqhBsNGPBTnHsbRaEfUEKY86LRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b6::9)
 by PH7PR84MB1416.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 2 May
 2022 17:15:14 +0000
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1d3b:32cb:5dca:4e40]) by MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1d3b:32cb:5dca:4e40%4]) with mapi id 15.20.5206.014; Mon, 2 May 2022
 17:15:14 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Chengguang Xu <cgxu519@mykernel.net>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [RFC PATCH] RDMA/rxe: skip adjusting remote addr for write in
 retry operation
Thread-Topic: [RFC PATCH] RDMA/rxe: skip adjusting remote addr for write in
 retry operation
Thread-Index: AQHYXek3BpF1Z+1XI0CRMsN+QQ9eLa0LzWdQ
Date:   Mon, 2 May 2022 17:15:14 +0000
Message-ID: <MW4PR84MB230773A6CD5414E6CC8E502CBCC19@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220502053907.6388-1-cgxu519@mykernel.net>
In-Reply-To: <20220502053907.6388-1-cgxu519@mykernel.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 464302f8-af51-4838-1370-08da2c5f52a6
x-ms-traffictypediagnostic: PH7PR84MB1416:EE_
x-microsoft-antispam-prvs: <PH7PR84MB14160937CCA92557BA0F2FF9BCC19@PH7PR84MB1416.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D8Y4BFfn8XaV+itPM3kPds/sQbkDeP2yw3l3DPdkO22t8Gy3z/BrhYAj+j9lxH1RBwSpHPr6wrs9JKI6lSliZcu0lQjtn7QSm2uybD+845R0+jyYfJa1L5Ab/GFoG//Lk2nmjq6D0Zi1U9LOBhhPou5BnrfMxNi0xhid43VM8vgS9JwV7zzrTKRYE5V4VyTj6CQWVdD/cDWGqQIQiU3gm5iyN3fuofw9VmaTHm+iqgipKtSnyq/zkSoY0+sWOA9tIggI+crjLB4FNAgjM65nrahyD5uope/2ycZp2JkkYnGFysnGZ1DB4/DNBm87x1iPPlF9jr7Mtjpu9O9hFzyIqxuSAIILjq3g98Mq/m62n4c52vBBoFst3+WonTpVVSBUa/8xuIU61UBb0yvVpkeEQTzAHfxDCVIYENX7CVbBjH6rnq1qzfmrOKg8wM6PKQOWgIvsxD6PH3rbyaEe1/Kc7Q9tW+ZCeHOhNOQYhdoiu0cd0OMZFhfvpk1AM2zgGhr9ut8yh5HghwcC2tBcj41T3z1lpE7+Vxa5rNA8aJFQAkcVDA2R9mZ6tSKC7z8Ak6GmESQxo67anCRvgKWZO+JA2qm8FVTDPjR71F0nScfxONRtcslNArlqH+Kc0oNo7+AvJFWucXvZUkR5dhZGChcpHydsdjD2GqpfPNy26kbPj5NK6K4bGix2DJM+VmytfsZ8dy/VeWoRkg3COlAzYJeLHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(7696005)(83380400001)(52536014)(9686003)(5660300002)(86362001)(122000001)(6506007)(110136005)(38100700002)(55236004)(33656002)(508600001)(71200400001)(82960400001)(316002)(2906002)(53546011)(26005)(38070700005)(8936002)(8676002)(4326008)(186003)(66556008)(66476007)(66446008)(76116006)(55016003)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0xYbW1jdnlGU1ZZQ2tNWDJ3blRYK0sydk9pTS90cXJzbXQ1cUc4QVg0R3VF?=
 =?utf-8?B?MndPZlBMMlpnamRsZmVwTngxQU1RcGZ6aE1YVHp4eWpEYWFEMmExM2NLT0hv?=
 =?utf-8?B?TUZGdFhidzgvVkxlU1A0VGdVNGxZYmx1QVJWT1RUNjg5dVZWNHZQN1NER21H?=
 =?utf-8?B?TzFpQUpqMW5Uem8wclhIYWhRRUNDYWd6UExsbXdpbVp4Y2ZVc2RnNFhWcTNa?=
 =?utf-8?B?VExicFpVWmFnaE5ZMzFMSE5KWkJ0RERDVHYyTU9PNnZXTWZlT1JOdGU1djZl?=
 =?utf-8?B?bVQwc1JCRXVFTDhLZ0YrSml4S0JUbC8xd0UyemVYanNXWkIwZUpCK1JqSys4?=
 =?utf-8?B?QkNwUE9keTBsa3lYK3JLdFoyNFpyd3FpeGU2ajdQRXQvZzlzZmo3TG9VeW1a?=
 =?utf-8?B?akJSYkp6ZnlQbVhzeGpTeXRacDhITWYxQXcvU250b0pJUkl0QVo1SE5QWm1q?=
 =?utf-8?B?bWZQQ1pYcWd3cC9UV0UxbndoZjdRUTdvOTZVaXBvcWJCZTcyQUhaTWIvRTBo?=
 =?utf-8?B?Q2NGenhKZDk2OVhWRUxNNi9CSUZLTUd0TE1xTE0yODBUWEI2QUd1Qk12OFlT?=
 =?utf-8?B?bGlLNU5GVmlKcEkxRlQ5SGM3TzZUSlBrR0RtRzRuTW1WZ0hteEtOcXNCOTBB?=
 =?utf-8?B?SXN6ZmFISWpMa01wc2xRYlJmK2tHbWt5RWl3cE9VaTFGV3czVHNoS2FRamFT?=
 =?utf-8?B?NlphWXpDSUkrMHNJZnUzTXl5ZkIwUG9seTdOL01qS2NrOHBpWitXR2FhdkxS?=
 =?utf-8?B?eGVMdWJ4Zjc3Y2xVL3Q0cEJSdlBJbFFTbS9NNUJUaUhYdy85a1FiUitVZG8x?=
 =?utf-8?B?OENCK3NacDVHZlllanVObmlKc0IrTy9nNHo1cCtYT2gyR3NoOW9NK0FOOHl3?=
 =?utf-8?B?aUlGRVdsaGV1QWludUo1OFJFNmVKUXNERTdkdWtpVGtZZGNXN1p2MUxER3A5?=
 =?utf-8?B?T2MyNTBLVG05RU1KMWRpbFNETC85Wm96UlJJaTVXUzFMd24rRFd5RVhvZ2JK?=
 =?utf-8?B?eTlISkpEamk5cXkxblRpcWU0RGxoV25UUjI3dzZ2VkhzZzRRRkZtUjMwcUt0?=
 =?utf-8?B?U3lEUEQrSEszOXU3M0JLZnBYMXhDM2tFUDJ2ZFk3eTU1eFg5d2dmYW42WUtx?=
 =?utf-8?B?T3ZKWmhSeitrOGtSK2VFVlRYU2JXaGh1Ui9zUGFnZjZZMGdMSGg0U0hxZHNW?=
 =?utf-8?B?ajlKcld1SG16aUlXV1VTN0l3eXBNZ0w5cWJkZUxKL2tYS3hOQzc0UFdkR243?=
 =?utf-8?B?UUZtcERLR2VyaFErZTMzZ3YwemVFRHJTK2hKSEM3MVdrWnV3dmtobXh4QS9x?=
 =?utf-8?B?MTNBZm5ob0ZYd1NsUm5OUU5rTUc3QVpITXNZN0hDb3ZXZnBMQnFKVEd1Um44?=
 =?utf-8?B?dkJYY3FqWDU0dG5DQUVZTVlBM2hsZUdDMnF6aUV5c2lRL3lTMjdUL2R3QzFL?=
 =?utf-8?B?M1VmeUZQYk1vRlFCNk5XdHhMQlZpUm9UUjNCSFdIUmttdDhsSUo2bFdTS0I4?=
 =?utf-8?B?NktpZkFadlQ5VUNnZFBOVU1mUHh1NjFnamg5dUQ5Y0JzZUt3NDVmTkVsT1NE?=
 =?utf-8?B?aGxCNkpVRnhjYXR2NzFIamRhZ1ZEcUJvalZiUGY2NmZiaWhGVHkxOHpDMWpp?=
 =?utf-8?B?cEhNWC9BKytIZExGdktNQWl0cUI1RjZSdTd4a2J5NHU4K3JySmpDUklqQkNu?=
 =?utf-8?B?aU0wUUJwT3dVaVFxWVVrK3Fva1FBRWJVWlRNcVQ0WktlNnpCZm9PZ2dsOGhF?=
 =?utf-8?B?VnBwQmRlOVJpM0NFNC9wYTNkOTlLaE5WdWJ4cGJrTWdLNUtBMFJqeWxHMzJu?=
 =?utf-8?B?S1F0RXV0QkFFQXpIR0tKemphZlFIMlU5SVpGV05hdE9GQ0JsWDBjeHRjTy8y?=
 =?utf-8?B?L0dGa0tkajVmUmwyTkNKcU51K2VPR3dvcWF0SFQ1Qm1kVEdiZXRQc3l0ODZz?=
 =?utf-8?B?Q1NRWXduWWxwdGg1Znc3VFhJWUMxZ1lSbzk4Q2FCU0dkRmQrSXBqWTYxd1Vi?=
 =?utf-8?B?MFREOHQ4MU8rc05VQU1HdDdzOFpyYmIxUGR4d1ZMSHN4dUxwU1U5cGI3ZzFh?=
 =?utf-8?B?ekVqZUQraFVvWG9VOW5yRU9xUm1kZXVGU3JkekVWdk5raWxTb2JIZWNOcGlI?=
 =?utf-8?B?MktTVTdRVWw2WldzZTNSTnY5TVZGUEJzVDl3NTVLQ2YwNTZpbUZvd0p2bTBq?=
 =?utf-8?B?R3IrTGozbFYrRDVNMjlvaFpFT2hVYVJzb0VNcDNwMkh5MHo4OVpXZk1nMnBM?=
 =?utf-8?B?QmpVZVprN1JRUkYxQmJNcjZhWnAwcDlITU44NWgyR3BZU1NyV01FYUtQSFlx?=
 =?utf-8?B?aE5JanQ2aXh1VlFHZURVdkZOczNPaTNCdFkvYit3dnNnVEFHekFiZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 464302f8-af51-4838-1370-08da2c5f52a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2022 17:15:14.5852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gyKtj3Uu/L9nD7cDl7oSJReptdIERfycgQjTJBWMnXNbIDHTvX0Re1AJkecRRJIkAcYl3yvwdrXulVuToS4MWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1416
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 2m1jgyvQqTh50goIg7bkQVJ8_T-lwJ9j
X-Proofpoint-ORIG-GUID: 2m1jgyvQqTh50goIg7bkQVJ8_T-lwJ9j
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-02_05,2022-05-02_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1011 impostorscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205020129
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaGVuZ2d1YW5nIFh1IDxjZ3h1
NTE5QG15a2VybmVsLm5ldD4gDQo+IFNlbnQ6IE1vbmRheSwgTWF5IDIsIDIwMjIgMTI6MzkgQU0N
Cj4gVG86IHp5anp5ajIwMDBAZ21haWwuY29tOyBqZ2dAemllcGUuY2E7IGxlb25Aa2VybmVsLm9y
Zw0KPiBDYzogbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IENoZW5nZ3VhbmcgWHUgPGNneHU1
MTlAbXlrZXJuZWwubmV0Pg0KPiBTdWJqZWN0OiBbUkZDIFBBVENIXSBSRE1BL3J4ZTogc2tpcCBh
ZGp1c3RpbmcgcmVtb3RlIGFkZHIgZm9yIHdyaXRlIGluIHJldHJ5IG9wZXJhdGlvbg0KPiANCj4g
Rm9yIHdyaXRlIHJlcXVlc3QgdGhlIHJlbW90ZSBhZGRyIHdpbGwgYmUgc2VudCBvbmx5IHdpdGgg
Zmlyc3QgcGFja2V0IHNvIHdlIGRvbid0IGhhdmUgdG8gYWRqdXN0IHdxZS0+aW92YSBpbiByZXRy
eSBvcGVyYXRpb24uDQoNClRoaXMgaXMgcHJvYmxlbWF0aWMgZm9yIGxvc3N5IG5ldHdvcmtzLiBB
IHZlcnkgbGFyZ2UgcmVhZCByZXF1ZXN0LCBzYXkgOE1pQiwgc2VuZHMgMjA0OCBwYWNrZXRzIGlu
IHJlc3BvbnNlIHdpdGhvdXQgYW55IGFja25vd2xlZGdlbWVudA0KZnJvbSB0aGUgcmVxdWVzdGVy
LiBJZiB0aGUgcGFja2V0IGxvc3MgcmF0ZSB3YXMgMSUgdGhlIHJlYWQgcmVxdWVzdCB3b3VsZCBu
ZXZlciBmaW5pc2ggYXMgdGhlIHByb2JhYmlsaXR5IG9mIHNlbmRpbmcgMjA0OCBwYWNrZXRzIHdp
dGhvdXQNCmxvc3MgaXMgdmVyeSBzbWFsbC4gVGhlIHdheSB0aGUgY29kZSB3b3JrcyB0b2RheSBp
cyB0aGF0IHRoZSBpb3ZhIGlzIGFkanVzdGVkLCBhbmQgaWYgeW91IGFyZSBsdWNreSB0aGUgcmVz
cG9uZGVyIGhhcyBhbHJlYWR5IGZpbmlzaGVkIHRoZQ0KcHJldmlvdXMgcmVhZCBvcGVyYXRpb24g
YW5kIHN0YXJ0cyBvdmVyIHdpdGggYSBuZXcgcmVhZCByZXBseSBzdGFydGluZyB3aXRoIGEgZmly
c3QgcGFja2V0IGF0IGlvdmEuIElmIHlvdSBhcmUgbGVzcyBmb3J0dW5hdGUgdGhlIHByZXZpb3Vz
DQpyZWFkIHJlcGx5IGhhcyBub3QgZmluaXNoZWQgYW5kIHRoZSByZXNwb25kZXIgd2lsbCBjb250
aW51ZSB0byB3b3JrIG9uIGl0IHVudGlsIGl0IGlzIGZpbmlzaGVkIGJlZm9yZSBsb29raW5nIGF0
IHRoZSBuZXcgcmVhZCByZXF1ZXN0IHdxZS4NCnRoZSBjb21wbGV0ZXIgd2lsbCByZXNwb25kIHRv
IGVhY2ggb3V0IG9mIG9yZGVyIHBhY2tldCBieSBjaGVja2luZyB0byBzZWUgaWYgaXQgc2hvdWxk
IHN0YXJ0IGEgcmV0cnkgYnV0IHNpbmNlIGl0IGhhcyBhbHJlYWR5IGRvbmUgc28NCml0IGRyb3Bz
IHRoZSBwYWNrZXQuIEl0J3MgbWVzc3kgYnV0IG9uZSBjYW4gbWFrZSBmb3J3YXJkIHByb2dyZXNz
IH4xMDAgcGFja2V0cyBhdCBhIHRpbWUuIEl0IHdvdWxkIGJlIGZhc3RlciBpZiB0aGUgcmVzcG9u
ZGVyIHNhdyB0aGF0DQp0aGUgbmV3IHJlcXVlc3QgcmVwbGFjZWQgdGhlIG9sZCBvbmUgYW5kIHN0
b3BwZWQgc2VuZGluZyBwYWNrZXRzIG9uIHRoZSBvbGQgcmVhZC4gSSBoYXZlIG5vIGlkZWEgaG93
IENYIE5JQ3MgZG8gdGhpcyBidXQganVzdCByZXN0YXJ0aW5nDQpmcm9tIHNjcmF0Y2ggc2VlbXMg
YmFkLg0KDQpCb2INCg0KDQpTaWduZWQtb2ZmLWJ5OiBDaGVuZ2d1YW5nIFh1IDxjZ3h1NTE5QG15
a2VybmVsLm5ldD4NCi0tLQ0KIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jIHwg
MiAtLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cv
cnhlL3J4ZV9yZXEuYw0KaW5kZXggYWU1ZmJjNzlkZDVjLi5mMDgwMTA2NTFlZjcgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXEuYw0KKysrIGIvZHJpdmVycy9p
bmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMNCkBAIC0zMyw4ICszMyw2IEBAIHN0YXRpYyBpbmxp
bmUgdm9pZCByZXRyeV9maXJzdF93cml0ZV9zZW5kKHN0cnVjdCByeGVfcXAgKnFwLA0KIAkJfSBl
bHNlIHsNCiAJCQlhZHZhbmNlX2RtYV9kYXRhKCZ3cWUtPmRtYSwgdG9fc2VuZCk7DQogCQl9DQot
CQlpZiAobWFzayAmIFdSX1dSSVRFX01BU0spDQotCQkJd3FlLT5pb3ZhICs9IHFwLT5tdHU7DQog
CX0NCiB9DQogDQotLQ0KMi4zNS4xDQoNCg0K
