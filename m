Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B9B72A107
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jun 2023 19:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjFIROI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jun 2023 13:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjFIROH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Jun 2023 13:14:07 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C13211C
        for <linux-rdma@vger.kernel.org>; Fri,  9 Jun 2023 10:14:04 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35996q10027370;
        Fri, 9 Jun 2023 17:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=RmuSY3xHZX9ke5k1p1FPKUNbwSHh6R/EBGeh8KqISHI=;
 b=CuzkleI4UHe111O4e7praWJPWdnkdf5BnjpNal1dhps5kjZ0MizQmEZFfpuSdub0gAi7
 2zg1kj99IT8/kCc4PJ+4n8tDy5kP6WVl0fdNrEgGslaHC68vHSPAXlB7BFQrlN8BikS8
 A+LpE+n5AvOaiK+r87yp9fEnwiXzeS7p4MOfv5yWVoPDey8elzwH1/NoD32Ry6ib5q8S
 lHlcXPDq/NW79xNkMz4J1luLaXQcDdmbbEhMRaWO0PmKT+WZpD3tJpPm+cx98uOrFi2m
 VPuFpmxvLSXwHSgydVJA1k+2mCiTxsRuEp/QZd5suWeR8c/9wZPOyKUADD3BPxdKs6aD Gw== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3r3p0e7nm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 17:13:54 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 6B12B12B46;
        Fri,  9 Jun 2023 17:13:53 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 9 Jun 2023 05:13:53 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Fri, 9 Jun 2023 05:13:53 -1200
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 9 Jun 2023 05:13:52 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFMYAlJ29A6O+VBUlRM7pJxRWuuL/6KCGIt1QC5t9apG2WbLCQHlmsVQwQSI7UW+P6kVqQ0/wMUy8CDZG8W2+wk0RtQ8arhvloWjwRRjdkjtNhryOjmaYcRfot8Qpix3qm/ujaRNDdaslRgvyozIElWs7ORU8VVkdJZd8sD3QV6SKGj0FIAkUCmPhQb/PKwkq+4eCP1qYww4L0+x3jNUVvjQQnjo32M6jD35xBgjMboZKZQoi7J0DCG1L4uID0NUqD+jTaO2xRThdcB4JXG3hkpPVIvDQVv38FHUo5n/kMwwUWWkQoQqrRBaZ5tdvE11EndZAirCqFeNRHkpKWiuTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmuSY3xHZX9ke5k1p1FPKUNbwSHh6R/EBGeh8KqISHI=;
 b=YA3KE3zyAW4IlU9J79rRlcCsQGICqMCiWEq5PWifVR7TieB784hPXFbnudwrHWJdxKSO3Gw6i+BrmOsgN0r6aC6jUh/3/jPWoefhVDnU4Sc3Mwj+z0dGp8XKsRok6Kd1g2p6YDDnM37ctxX5KY8EHwRv00PHZbvvC1qGC8nTCyjwFDPD9wyQPDSy5a6iUi0tjqNIYcAYkRPl0ThDA/CSpdcbrIamt6/OLwztPdCDDpgBOlbYRUGtYZlWC2Xvt/W+a1Dw9l96hUCEWXuA+XQQSGNx9UnqPKszdJT0gKJdWoKvl1ybXFqDpZL083RftE2r2mHBhgZ38miJ/ZJTbMGGNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b6::9)
 by MW4PR84MB1802.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Fri, 9 Jun
 2023 17:13:51 +0000
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ad7a:bf67:d9d0:371a]) by MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ad7a:bf67:d9d0:371a%5]) with mapi id 15.20.6455.043; Fri, 9 Jun 2023
 17:13:51 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next] RDMA/rxe: Send last wqe reached event on qp
 cleanup
Thread-Topic: [PATCH for-next] RDMA/rxe: Send last wqe reached event on qp
 cleanup
Thread-Index: AQHZlXFDAJfXcPLcuUWsdl0vWFueLK+Cv64AgAAAoZA=
Date:   Fri, 9 Jun 2023 17:13:51 +0000
Message-ID: <MW4PR84MB2307D9015B636120A3EC1B59BC51A@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230602164229.9277-1-rpearsonhpe@gmail.com>
 <ZINdAjjfwldp1iMc@nvidia.com>
In-Reply-To: <ZINdAjjfwldp1iMc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR84MB2307:EE_|MW4PR84MB1802:EE_
x-ms-office365-filtering-correlation-id: 2eddd583-ffc5-4c83-8df4-08db690ce56b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 04WSmCiHLEzY1xowRkluEftt1oIVsxKvV/agBFTREyL7ytetmgu0wEhlWMoSy2ZerHqBV87Y2anvA2Wn7TnS+4P79oA8tv1UT8CNhA2/j6J/xIno9Ohj/Jw9h0hPoM0bEwjjeV/8gwnYM5jlRRyySHg5F8WMyTHBU33D3k4emWaRU74e1L+NYKRa8o6LjR9H8cGQDvujiVS6jQeYymIG7oNYDB6ftuvaSojY1OAn3SzkTCrUhbHfn29+CxOPHycVV29NQ0wooyiPb1xruAif1BEejH6YNcdb+G7LxQAt0caj2He9UgWA+JWKCB47wGU31YPgqOajsFyVfEgLjxg8Ok3cwnBysLIuCPyARIAsq/hG+Hqeanu52wd8OfgWHZolZ6BQlyzTFghXoBRUMEyjUIchVZPCW22Gur5SrQ6bOXFSinlxtKuARnrrHUsb2tWzQIWdhccQ+niv2gtDirb/Y5A0Y0DDhYzbE8vqD2JCj1xU9jTyTcudVC0hIXi82ZTQt9KvVInJqJJwX5Q09Qv8l84z2zgiBnbXZmN9U4YSLGqlJI6TC1FPkq7Xc76kD1pBx1kV3CPq9CLLp55v171CtCHx7BFAGGuH6zggZapemt2pZS2FwiKSKmMKGGmuLKu5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199021)(110136005)(54906003)(38070700005)(2906002)(52536014)(5660300002)(7696005)(55016003)(71200400001)(86362001)(478600001)(41300700001)(33656002)(82960400001)(6506007)(26005)(316002)(38100700002)(53546011)(55236004)(122000001)(76116006)(9686003)(66476007)(64756008)(4326008)(66946007)(66556008)(66446008)(186003)(8676002)(8936002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDdERk5GWC9CTm5CdG16QXo1UDFQQUhaSmc2bTZ0YzJXcUNzTVY3TDVKa2gy?=
 =?utf-8?B?RkptekgrenZhRmY2SlRyRW16ckZ4bjB3eUdOUExnczgydUFLK1A3K1RhYVg0?=
 =?utf-8?B?Z0ZVR0JOODlxLzJpVnFSSnR3WTh4Sk41Y3NDcUQvUE8xYVExeTQ3UHk3dGc1?=
 =?utf-8?B?RFZaU2hhWkpraVVMMEdmbkdGVUZ5a2FiUk5CUi9GWGNaZGRLL1hCbXN4bjcw?=
 =?utf-8?B?UWtwekZPRHBWTnpOcWxJT01BdkJlNWY2bFVBVFhtUFVlckZBMTBsWU5QSEI1?=
 =?utf-8?B?VWxOVDl6VDVlbzY2MVlBcGh6dmxvbFdyVUIwSmhpQnl1MmFURWpQWmE2TFZG?=
 =?utf-8?B?M1ZDb3BxWFByYm4wQXpVa3l5WXVQTU5iVVlpRmswRXdFSW9pby9zWjgrb2pF?=
 =?utf-8?B?NWNpbDRNWEdtTGF4SGJpY09BaDZzYm1KTmwrYkhGOHJ4aFF1V1VGMjNNMlVm?=
 =?utf-8?B?T2Q1QUJlaVFQRzVjVzAvZU85dHc5TWRaU25hN1U0UHBCUzZ1c25USDFqVGFq?=
 =?utf-8?B?OEx5Ykx1UUVUUVhYZUNVQXozbDdTcVNFVWJwKzF0ZjJZazJrd1kzbi9YUXhP?=
 =?utf-8?B?dnhyTnp3WGVCZm5kT3ZyUGZBQkFxMlZZMU5DdFpZN0xTcC9PRmVJVGVzcVN2?=
 =?utf-8?B?UGhYcXl1S0Y4clVqNnZIYnJic1NVZmZudTRTY3UxSTFqTTNtdG5saDF4RW1V?=
 =?utf-8?B?U3Nvd3I1aVpJNEZBd1FvcTBzUTFGK1FOTFhXOUd3dmlablV0eHBnR2NvdlJ0?=
 =?utf-8?B?SHo4QmJsbEFsOHJZZHpLcXdmWWhXOTBpV1hoMDlLV0ZiRW1iTkJNS09Ja2Ey?=
 =?utf-8?B?MnZVazgzSlIzS0d2TlFHcXZZbjIrdGJNTU50RU56RzdpWm8vZEdqcmwxZmtO?=
 =?utf-8?B?Uko3RlpUc3poem1oTmpjMWV3NEFiMzBIbVFSNW52QmY4Ykt0N0NBOVRva0Np?=
 =?utf-8?B?MGZJVEYrcE41ZEUxRlUrREI4TlVZWDE1Z2o5MmJack1JajZrVWhwS1RZazdD?=
 =?utf-8?B?NCtVL0RYTVprYndVUFlldW9CZ3A1NkN0T05sNkI3N0JKdWlIeUhsSFBTdmpp?=
 =?utf-8?B?UEo0Z3ZIMmFiM2sya1kxZElWNXZFM3ovckVybnNlVzB1WlM4ODNSTlNVVkNn?=
 =?utf-8?B?MFB6SEh5VVFLOEVwcVNwK0VVN200WHM5eStLckI4blNwU0FYWEU3eVlIMk9j?=
 =?utf-8?B?VDREVU1QZjc3aDBRY2NRck5vYzVyaWpJeGNkTitxQXd2MlBYRFB4YjF5Ykt5?=
 =?utf-8?B?RS9KTDdPMGtOUFIwTUNMdUlVb0dxZkFrWTBUdkgxbmZOSUh3OWFYai8xaVZy?=
 =?utf-8?B?aWVDcDNjZUtwVi85V2ExczBiTkpuTDVsa3RIcE90YzdZRzUveEJvUHdRTFdD?=
 =?utf-8?B?MkRRNmdrNklDVUdRaWh5Y3lFZkphUWNOeVRSQXo1UWdtTVV2Q3VFS2pvaGUr?=
 =?utf-8?B?WGVGMG1TNXdaTnoxQlZtWkJRTHNrSHNQNjduTHlvYlFnVnNNWXl2RGVzeTVi?=
 =?utf-8?B?UWVQb2ZONUxPMkZzWkVheFFGSEM3ei80OVlDczBDaVJQQ0dQL0lIOVZXanQr?=
 =?utf-8?B?cUl6eDM1dW95L1Y1VGhnRVNvaksvYjFONmtLRmx0VzhLL1Bma3hlYWNBVy9Y?=
 =?utf-8?B?anNlSFhFdjRpRWdXSk9obUtwdWFzRXRkZ25JcUluQnNWTHczc0tjRy9Ob1Zz?=
 =?utf-8?B?b0V4aDhTTEV1d1YyOW5RbHNDVFRLeDIrUkFjeVhPVG83NHZlc1pheHhkZ1BZ?=
 =?utf-8?B?V1ZmTXA2YWh2NFpGWmE3bFdTcVFCbkZlSG5weWhma2VIa2ZEZ0ZvNHkwcWR1?=
 =?utf-8?B?S24zcUt2WVlWOUs2RFRpNGs5dS9sbXV2OFFwYU9xa1Z6MUt1YVNoaHFUWHNL?=
 =?utf-8?B?SnlES0R2SDVFTy94UGJwQWdCQUNkRnlrazVib0xmZHhIbG5KaFFkVVpsTFpJ?=
 =?utf-8?B?bTZpZzIyQWRERTdHMGdBSXZuUHQzRFgxVGJ4YXRnU29IL3BHQmZRNmNMR0pY?=
 =?utf-8?B?bXgrRHpkU3ZORk5xTG9SczBnL3RrZS94K240ZGI2dngzWUtEODVscDBoTDNm?=
 =?utf-8?B?b3J3QVlLdVlSRDVWTEo4K0NYNmM1Y3RuQUJYOGkvTkMzTm41bkpwL3IzU0xT?=
 =?utf-8?Q?cKlRb/OaimMxB7Jqk4i45rhdd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eddd583-ffc5-4c83-8df4-08db690ce56b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 17:13:51.2165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: InE/SC+/0FgX5iwc1pXY4rVlq9oTu1ZfEW2XU1o6k1NVDiVt1yId9fWc7W936shXgLkelJYF+l0Nt7xsXOyUYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1802
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: aNqXJZ_W37CbJnHtEaDCetJCh6gn7_y7
X-Proofpoint-ORIG-GUID: aNqXJZ_W37CbJnHtEaDCetJCh6gn7_y7
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_12,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=592
 malwarescore=0 impostorscore=0 clxscore=1011 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090144
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

VGhhbmtzIEphc29uLCBUaHJlZSBpbiBvbmUgZGF5LiBXb28gaG9vISENCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+IA0K
U2VudDogRnJpZGF5LCBKdW5lIDksIDIwMjMgMTI6MTAgUE0NClRvOiBCb2IgUGVhcnNvbiA8cnBl
YXJzb25ocGVAZ21haWwuY29tPg0KQ2M6IHp5anp5ajIwMDBAZ21haWwuY29tOyBsZW9uQGtlcm5l
bC5vcmc7IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIGZv
ci1uZXh0XSBSRE1BL3J4ZTogU2VuZCBsYXN0IHdxZSByZWFjaGVkIGV2ZW50IG9uIHFwIGNsZWFu
dXANCg0KT24gRnJpLCBKdW4gMDIsIDIwMjMgYXQgMTE6NDI6MjlBTSAtMDUwMCwgQm9iIFBlYXJz
b24gd3JvdGU6DQo+IFRoZSBJQkEgcmVxdWlyZXM6DQo+IAlvMTEtNS4yLjU6IElmIHRoZSBIQ0Eg
c3VwcG9ydHMgU1JRLCBmb3IgUkMgYW5kIFVEIHNlcnZpY2UsDQo+IAl0aGUgQ0kgc2hhbGwgZ2Vu
ZXJhdGUgYSBMYXN0IFdRRSBSZWFjaGVkIEFmZmlsaWF0ZWQgQXN5bmNocm9ub3VzDQo+IAlFdmVu
dCBvbiBhIFFQIHRoYXQgaXMgaW4gdGhlIEVycm9yIFN0YXRlIGFuZCBpcyBhc3NvY2lhdGVkIHdp
dGgNCj4gCWFuIFNSUSB3aGVuIGVpdGhlcjoNCj4gCQnigKIgYSBDUUUgaXMgZ2VuZXJhdGVkIGZv
ciB0aGUgbGFzdCBXUUUsIG9yDQo+IAkJ4oCiIHRoZSBRUCBnZXRzIGluIHRoZSBFcnJvciBTdGF0
ZSBhbmQgdGhlcmUgYXJlIG5vIG1vcmUNCj4gCQkgIFdRRXMgb24gdGhlIFJRLg0KPiANCj4gVGhp
cyBwYXRjaCBpbXBsZW1lbnRzIHRoaXMgYmVoYXZpb3IgaW4gZmx1c2hfcmVjdl9xdWV1ZSgpIHdo
aWNoIGlzIA0KPiBjYWxsZWQgYXMgYSByZXN1bHQgb2YgcnhlX3FwX2Vycm9yKCkgYmVpbmcgY2Fs
bGVkIHdoZW5ldmVyIHRoZSBxcCBpcyANCj4gcHV0IGludG8gdGhlIGVycm9yIHN0YXRlLiBUaGUg
cnhlIHJlc3BvbmRlciBleGVjdXRlcyBTUlEgV1FFcyBkaXJlY3RseSANCj4gZnJvbSB0aGUgU1JR
IHNvIHRoZXJlIGFyZSBuZXZlciBtb3JlIFdRRVMgb24gdGhlIFJRLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQm9iIFBlYXJzb24gPHJwZWFyc29uaHBlQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXNwLmMgfCAxMSArKysrKysrKysrLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KQXBwbGllZCB0
byBmb3ItbmV4dCwgdGhhbmtzDQoNCkphc29uDQo=
