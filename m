Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836354EC459
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Mar 2022 14:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241630AbiC3MjR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Mar 2022 08:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243837AbiC3Mhj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Mar 2022 08:37:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD52D9BAC6;
        Wed, 30 Mar 2022 05:27:06 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22UAj7Ih011946;
        Wed, 30 Mar 2022 12:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+TXDYnWZrXFt7Z3of4D67vyHDAwmn0zkkgBuQL13K30=;
 b=HwuZtre6mASNRpMsEXsU/KJfb5F5NieKkbeeO4yo4sjZPqi2Hv+xObR4SawT1GtBBHlj
 /c2xnd+ldU7jIrU85OkCGCYpp7QmUXfjxmt7Asih/t++V0SCy//2Q38GnE+UxKZGOVoB
 8pMQWkIPjayRHfRjODAVEMkXxgteYJzrJfw79EXf8kf7S17I5Z2wK7ocB0zIurkyNkeL
 kpGdCNfPN8K/dFXOLcTcXdj9uBhoXqJtsmAHqzhfA0n7Rr6gBeubVwtUqy6C9WHyKaYW
 fFr8M04F4yGa8+eusMfuW1RjRs9fWqjOQQB4nGIO34iP4ftjQUb2duTymIcXnkHq9G7y pA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1uctsfrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 12:26:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22UCLCDo096943;
        Wed, 30 Mar 2022 12:26:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3020.oracle.com with ESMTP id 3f1tmypf6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 12:26:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYBerO68Oyh0cIW1GlBgei6xOsbqGObMmKk5zCowbWlbxCiTksl2cN3Hp2OZq5KhTMLpFAFfGVrBIjaGv1pDLixYYucGL3k+XZ0vOxuAtsb+MyL/av1FzornT4SrAemvcW20P3Q67zIz2hJ8MnGZXVc7rnjF6HASJLh3ti0eTIFmkmu2cbh1oXWYxBMqQ2WprU6fa3a/XLs6+XEw3DjRyLhtJYqF1l1aL+7nAWO1buISxOdkqoX4Y+g31xvB+6kNZ9f//mHUvjDClr33fc2zKBgkApx2plVvzMJJhFStzNVSMJfed5j39ZLvzPe+bOR7jIGuSec1OdtbPV9BjyvfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TXDYnWZrXFt7Z3of4D67vyHDAwmn0zkkgBuQL13K30=;
 b=IZFvnbk19esvn/NwGz94rLJceRkAqnus5/Xo1OMLZZqgOyRqR6Oggn2X0LWGSwuGealntQm4Bb0xhrO0zcZ3y6B3e/IR7Vkb8hKmCB6YlrOJeE/wcj32WkDTzwKCXePeRk5WMWP/D/OyWpBpUGMI1+nlErmKhBnzRUGBTE4WjvGKpgPiqulhKLmecYNsnY1cqg9l3qb7U17H7nXBt7N7mQ5w/o/KJL0HZCDWy7B8GXMSs4mjfgAdPvj7xoRR0P5u5mwtb7ukqFQyukPjlB3W3Ej8n5PGWbEQlymyQORybbVWSjGZgvHby6RdkJ586sR/MWZd7ReAI8HWaF+CDEtAnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TXDYnWZrXFt7Z3of4D67vyHDAwmn0zkkgBuQL13K30=;
 b=OyIFJFBW6TJztk4cp8Voo0rptdD+kkelMMw1RaQC29XLfv9JX8PjkKugt/odwYk7GjSWFaCikzb5CXDARVv6h6KAH47/WfJOqHyMYGUMLNEzIYqFapOGpWHYRj15EWkOw7guCY3wMjg2XLLlbVGXrkgqMRHizgwz089P8ZeRscY=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by SN6PR10MB2430.namprd10.prod.outlook.com (2603:10b6:805:47::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Wed, 30 Mar
 2022 12:26:51 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::9991:af0:95:7c7c]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::9991:af0:95:7c7c%7]) with mapi id 15.20.5123.018; Wed, 30 Mar 2022
 12:26:51 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Guo Zhengkui <guozhengkui@vivo.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "zhengkui_guo@outlook.com" <zhengkui_guo@outlook.com>
Subject: Re: [PATCH linux-next] RDMA: simplify if-if to if-else
Thread-Topic: [PATCH linux-next] RDMA: simplify if-if to if-else
Thread-Index: AQHYQqUW7RAC7/tsRkWf8/UgsLthVqzXxh2AgAAA4QCAAAdrgIAADykA
Date:   Wed, 30 Mar 2022 12:26:51 +0000
Message-ID: <93D39EC2-6C71-45D8-883A-F8DAA6ECFEDF@oracle.com>
References: <20220328130900.8539-1-guozhengkui@vivo.com>
 <YkQ43f9pFnU+BnC7@unreal> <76AE36BF-01F9-420B-B7BF-A7C9F523A45C@oracle.com>
 <YkQ/092IYsQxU9bi@unreal>
In-Reply-To: <YkQ/092IYsQxU9bi@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.60.0.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10f52a2a-0d1d-4ccb-a589-08da12489168
x-ms-traffictypediagnostic: SN6PR10MB2430:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2430719EEC7DB87997195490FD1F9@SN6PR10MB2430.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V3Mu355Fcnoq24cIyN926SLmrf2JZ1uHtNjdY6wLzJMDY9Huu/r9evs4vvHDkAAiPEDK+gZy0JVMgGiQupIBaq6//sY4JE3OM9dsxmMDKK4W3tRo8PhXQ/MnZd045fZzJi2k/fgfGnzOlRd5hslvsm2cVGp7ig9fVfDv9G3Bv8H8joRZQXTtVYIerl4jqjh04T4XhRv1kHm3QNitXhO1HoV6qTfIWI6p0h66DZ1ZoXvNNSYLPOqqITd1hgecaCKsaq5P9O4QaZOwCEMDbqvGliVIhH61Givd497OE8COmCARqBbeQG2AXEyYYumoRAZNvmf3kOJaKsznocYKNi/o7il1uihIjdLhIq/r+AfKynsMvv1ZwnStu7vUa3ZVo4Fp5UF+/hkBr75O7n68lOmLCKX8WdPUI+5i7kRmUPHH/t4bCk0HPSQeh32Q39TQCUi/j75O54r5MF+siBm9I42lXTOKp2wfDbs5aEdcrNQA06s/HCXTP3HuRRS6QgV+Gu+VNOp55qO2gH5yenJ0lnjZKK3NhUqLdslhBXfVrXOwTw8SIIxlzDKObNGIcokgkW2icJcrq5Klf9BlyUREe20Jp6aAVM54L3sXOuQAQ/zCxr90wu6a0qoK2DfAFWqyhPYizrtsoaN2TjENWayeXSi/jQOEGxSgRIUrf4Av59qcApIZw3pHKPlQntR3dgeYTLkP8eFRjDTIvpdTslbaAK8CcWieRpuKq/ar4gI9n8tiu22QJkfce4iyZT9+s427yDG+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(508600001)(66556008)(6486002)(2616005)(36756003)(71200400001)(66946007)(64756008)(66476007)(4326008)(83380400001)(8676002)(66446008)(26005)(91956017)(54906003)(186003)(76116006)(53546011)(6916009)(38070700005)(38100700002)(6512007)(8936002)(44832011)(86362001)(122000001)(5660300002)(2906002)(33656002)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTQwNG5lVWRQR01Hb3JHS1Q0bVZRK0I4MkQxNW1YWldqcVBVQ1o0Yk1wUzFh?=
 =?utf-8?B?ZGNwcnQ4Vld2ckExWDBnVHNMRy9uWTVoTlE5R1FOV1ZRTFdSclU4MEVPSTdu?=
 =?utf-8?B?cEFQeWYxRldOYXJFUUU1Y3pmRVRreHNKQk9BSXJUU3hZSDIxaElIMm90Z0Jx?=
 =?utf-8?B?WHNremk4RDBnOUdjTjhITk1Ud1gwdE0yN2gvMVh0bUZ5dDF2QUdRcHBaQTNk?=
 =?utf-8?B?ekJnSTdrdEJoYVlSNEN5bnJvMlAvemVoOWt0SU9GTW1lM3ZkVHJjbVlvNnk4?=
 =?utf-8?B?N01HaEZxTGQycldFSWRqcW1ySGMvVVFMdVZHUi9tWFc3K0lrMDZyeWxFb1pa?=
 =?utf-8?B?R2xUdzlkczF5S0pYdEtRVHNmUTgzNUNrZUp3WVB3dU9rckd2U3ZySjlPYkV6?=
 =?utf-8?B?Vlc0VHNkbVdhTUJYVVVyb3JJZWNDblhzUFpxZEVRTHpoQy9MSUN2ZVBqMEhS?=
 =?utf-8?B?YWtvaXJWazUvZTJsYTFKcWJnRWc5UkF6WXg2N0FxcFpLY0ZNTmtpWEtLQ1lh?=
 =?utf-8?B?Y0RGUDZ4MmFraUI1SlBUZ1RUeUErYW5OanN3ZlJXYzF2V2R1ZStNb3RHRFc0?=
 =?utf-8?B?Q3JjMW9jNDB6L0hGVnllWUt2bVdSZXg0ZTVSczhjZGZkd1FSRGdIUEhLWjdI?=
 =?utf-8?B?c2dNUG40Y0hraXJ6VUhGZ3I3bEFTRGV2aVZXL0pad2N5U25FR1VLRzAzck9p?=
 =?utf-8?B?T3FVeWhaNXZpOEtjWkpFa1JvY2t4TUFuUEhnaTJuY2M0K2lzcXpZUWwyYXg0?=
 =?utf-8?B?YU1nbVBhdVdpcitoNi8zRVFpZTVDeVd6dm9UcktjRHR1QUg1V1hMQ0lHankz?=
 =?utf-8?B?YVUyS0hLQmliNjcyaXN6d1YvSnJVZXJBWDhMU3JhMDc0SW5CM2ExNi9obHl3?=
 =?utf-8?B?cTNqNWFnM1ZvaTQzVmxiMURSZnozV0FKbVlUejcwdGorZGpFWC9uYm52dTJN?=
 =?utf-8?B?SjNOMnVsZkZYOUZiZ1BFTG02bjFVQ002VXd3ZVArWkJGMFNkeWNFUDBpUDNL?=
 =?utf-8?B?M3RwL2s2QVJ4Rmt5YU4rZUpPNUl3bUNqOHgyeE1XRUNlYmdSdnNDTk1sd2Rq?=
 =?utf-8?B?T3BJWEZpaTYwSUxCZmlkNm1Bdi9kTW1VZFg5OVMzL2F0OVpJTjRUZkhYUXly?=
 =?utf-8?B?T0ZnMHRYRnR1QThpVzFpV3FuYlhQeWVZaCtkVmpGbzFORUlxeWhwYU1ZSERy?=
 =?utf-8?B?NHhtTTRWOGZjUDREVXFITEczdFZMQVBkbnpTekNYNFEwbzVkWXd2WXZwdE5C?=
 =?utf-8?B?Y3lpUFdBQ1NlVWZjK3kvT3Mxa2NmZ0IxTVp0OTlkSEFVcXJJeml5Y3lQZG5E?=
 =?utf-8?B?ajhnajBja3MwL2ZvdisvRWNiL0NwaDBUdzJ3QytHWEtMWEdPR3JKRktXajVE?=
 =?utf-8?B?UTRmb0lsdGhsK01xNk16NUdSNlZpSVlvdHBaSHhJdS9TcmVRVU9HZnpIOVRJ?=
 =?utf-8?B?R2gxRXVZTmRGTml6dDJ0R2M2aThVZjkyelAwcGpBM21RSmhJOG4wUDQ4MjNG?=
 =?utf-8?B?NExYQkJqUXN1clo1Q2F1emNLRXltZTVoZ1ZtOE5HczVCOFVFeW9VQm80MjN2?=
 =?utf-8?B?aVBwc2JFWE1jcm1BaGZTeFJIMXZ1NVp2U2tPdkRsOXhDb0lEdnI4amhuZXdr?=
 =?utf-8?B?VHhkWnBNOG51TFROZ2FrN0dYVHdRWHRucEt6VTdSZys4Yk5LTkVadElaZG5W?=
 =?utf-8?B?cFZQZHM4akdvSFJrYm8zVEQ5ZWdTVGZyZTV3Z0lVZzhGdENhQTB5TmYrc1po?=
 =?utf-8?B?YlhIL1h0ZmVZZzhoNjFVbUxwdVhEbXYydUVjQ3V0OHZKT0tKN3EzYXJOWDNs?=
 =?utf-8?B?b0VrNWpjVHBZdkZpM2NQUVlEdVE1TlVDdHM2RFA2NVpDd0JwNUNMYzJHWGR4?=
 =?utf-8?B?aDVxQ2puRkVkbVZVN0xDNGhORVh0VThZZER5TExKYWpPTkZVazdUYmtHTmp4?=
 =?utf-8?B?Zjl3NURVemRad3Z3VWFYMXkvTW44YXpGNmZDNkM1dGJRNHZTZkFmNi9lTGM1?=
 =?utf-8?B?bE9HWmQ0YkF3d2YvR2dhQkExUVA0d3ZVTnZKaEtzUnVuMFRIbkxTeklMRjVG?=
 =?utf-8?B?anViTytET043NUtkTFI5c3c0SWhCTVdwNVJVbkxkTHZOU3EzUTU4ZjJQVEYv?=
 =?utf-8?B?aVo2YnRjc3pjVU5OMXBwQTFxbUFkcmRHZENSWmFsTEZyYm5ndXRqaEhiV3pR?=
 =?utf-8?B?UU4rZzZkMzMxSUN0cWo0RmNxamhIS0t6MWN6UVk1U3dIRWN5MGQvSkgzZUFN?=
 =?utf-8?B?MGFzOUljWGlNaHZ3Q29OdWNuOVovMENUakJWcFl4ZFdhbHZiMDdjV281Zldx?=
 =?utf-8?B?ZXlFUGRMa2ZtR21nL25TQngrdjUrdVVaMjdhQ2ZEVEVrZjE4bDJ2QVdHdTI2?=
 =?utf-8?Q?jOsvc4TIsLzRUwJE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <671C6D1A704EC04CAB7FD98FF0B4A97A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f52a2a-0d1d-4ccb-a589-08da12489168
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 12:26:51.1918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kpp3/Uu5DFaOMd+1/gXXwW0uAYw/DJ1zY7wb9LN8y9g09nT4BVjLAZQtqAdie3Vd4kt0fJh0Dm5xGXylXKSU6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2430
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=866 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203300063
X-Proofpoint-ORIG-GUID: GBmeq1KQtdGhMcNRk_9CvRk3ZE9xZaoh
X-Proofpoint-GUID: GBmeq1KQtdGhMcNRk_9CvRk3ZE9xZaoh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMzAgTWFyIDIwMjIsIGF0IDEzOjMyLCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIE1hciAzMCwgMjAyMiBhdCAxMTowNjowM0FN
ICswMDAwLCBIYWFrb24gQnVnZ2Ugd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIDMwIE1hciAyMDIy
LCBhdCAxMzowMiwgTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+
IA0KPj4+IE9uIE1vbiwgTWFyIDI4LCAyMDIyIGF0IDA5OjA4OjU5UE0gKzA4MDAsIEd1byBaaGVu
Z2t1aSB3cm90ZToNCj4+Pj4gYGlmICghcmV0KWAgY2FuIGJlIHJlcGxhY2VkIHdpdGggYGVsc2Vg
IGZvciBzaW1wbGlmaWNhdGlvbi4NCj4+Pj4gDQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEd1byBaaGVu
Z2t1aSA8Z3VvemhlbmdrdWlAdml2by5jb20+DQo+Pj4+IC0tLQ0KPj4+PiBkcml2ZXJzL2luZmlu
aWJhbmQvaHcvaXJkbWEvcHVkYS5jIHwgNCArKy0tDQo+Pj4+IGRyaXZlcnMvaW5maW5pYmFuZC9o
dy9tbHg0L21jZy5jICAgfCAzICstLQ0KPj4+PiAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkNCj4+Pj4gDQo+Pj4gDQo+Pj4gVGhhbmtzLA0KPj4+IFJldmll
d2VkLWJ5OiBMZW9uIFJvbWFub3Zza3kgPGxlb25yb0BudmlkaWEuY29tPg0KPj4gDQo+PiBGaXgg
dGhlIHVuYmFsYW5jZWQgY3VybHkgYnJhY2tldHMgYXQgdGhlIHNhbWUgdGltZT8NCj4gDQo+IEkg
dGhpbmsgdGhhdCBpdCBpcyBvayB0byBoYXZlIGlmICgpIC4uLiBlbHNlIHsgLi4uIH0gY29kZS4N
Cg0KDQpIbW0sIGRvZXNuJ3QgdGhlIGtlcm5lbCBjb2Rpbmcgc3R5bGUgc2F5Og0KDQoiRG8gbm90
IHVubmVjZXNzYXJpbHkgdXNlIGJyYWNlcyB3aGVyZSBhIHNpbmdsZSBzdGF0ZW1lbnQgd2lsbCBk
by4iDQoNCltzbmlwXQ0KDQoiVGhpcyBkb2VzIG5vdCBhcHBseSBpZiBvbmx5IG9uZSBicmFuY2gg
b2YgYSBjb25kaXRpb25hbCBzdGF0ZW1lbnQgaXMgYSBzaW5nbGUgc3RhdGVtZW50OyBpbiB0aGUg
bGF0dGVyIGNhc2UgdXNlIGJyYWNlcyBpbiBib3RoIGJyYW5jaGVzIg0KDQoNClRoeHMsIEjDpWtv
bg0KDQoNCj4gDQo+IFRoZXJlIGlzIG9uZSBwbGFjZSB0aGF0IG5lZWRzIGFuIGluZGVudGF0aW9u
IGZpeCwgaW4gbWx4NCwgYnV0IGl0IGlzDQo+IGZhc3RlciB0byBmaXggd2hlbiBhcHBseWluZyB0
aGUgcGF0Y2ggaW5zdGVhZCBvZiBhc2tpbmcgdG8gcmVzdWJtaXQuDQo+IA0KPiB0aGFua3MNCj4g
DQo+PiANCj4+IA0KPj4gVGh4cywgSMOla29uDQoNCg==
