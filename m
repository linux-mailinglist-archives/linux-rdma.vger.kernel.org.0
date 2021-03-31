Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F8B3505B3
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 19:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbhCaRqP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 13:46:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50266 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhCaRpn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Mar 2021 13:45:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VHeWq4122740;
        Wed, 31 Mar 2021 17:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=u+plsDIUn7EnRtV74aw3JNtMWLTl7I2RR/lM2II8lJU=;
 b=xMhQwWkiciDZjRMYUwfhHccSjUujvobc8xgOz5RrEQiuLxRX2qpeToP203drO1RZBlJ7
 lFIvO9YWwMRHKHXryzCjgcUHedSKVHOnncLj5MoZ16TgM8eFsXUP4ZMOycD+WQ1Owdki
 6Sg2GbI4s/dF3/fb61OTK5h8MjtV4PFg+BO39mY7FlizEn1PbpviawR3qlt5yoZPFlcZ
 lSsrSPIT+L3yf5d+ZrUtJm6pCGssdHRhOZFBdxWuqK3yONYI0sODpQ7LdEioVyxAEKSF
 ABcA51pcUt/XqXJKSwXXK5qxPycQYEQSjyrgKl4fwLb9Z/z9C7dI6teqSwxfsSLP2fuv gA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37mp06skd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 17:45:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VHfWjf175408;
        Wed, 31 Mar 2021 17:45:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by userp3030.oracle.com with ESMTP id 37mabmhfqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 17:45:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vwzxp+DrqJr3jD2HBUg0Krj/Non7t3UfvdDNNM1hEd46gwi8+0yHNtWcsWovD/m7PPE0T9IplFwdQPnyCT7gdd3pmHXXldiZ60tmt9jx8VJ2qnkta7AeotbyhvksaTmmCC6zZGLxmdFTIiXHSf/9RMqiwEc6x13GH8kkJxjzJsh3F5kOwvyUOxZg5WGYjn1/cj7L8IboUGtgBOP9htNfl04xlIw/R32KKHNLzQomXsQ1z3Rl0kIzKBp3NHWVsJKxV10a3Ysy2Vcfrrz0T8qCA+vOcW6vGh8nwo8IrEZfOghcejMHakGEv4cUAU6phDV8BBO8QZ1wY169Qp6qc+2FRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+plsDIUn7EnRtV74aw3JNtMWLTl7I2RR/lM2II8lJU=;
 b=Co8aPCcHvI5dIPvjMxxawL0o6Owy2cMSyTZrKoA0PqjQwyiB+Qzkg1WIxQlqtQwsADXgjgmazZYRxztREPulJ5CII9y2O5pCl3I/r7WYK8KM4/AOGDKZkoKgHXtR99d5ZQ6OTilyHrmbnvT7IOUKnG3UBI25L1gpRERnnwF5PSfOOcBV3hm9sT75giGr3jPytrHlh935lFH3AEGFOmTyNAINxHxQmLaGVFOihZ/UuFYG8vcwz7YTWSZ0BcmbXMpAGo6oiyxmCBFzwbEhSZvJM32zaOXkgPslDwHDTAJ3ZZnIoQ3jm/8Rj+pZ/RM6z+FITHCyCeZ88fL/HsT7RBhm5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+plsDIUn7EnRtV74aw3JNtMWLTl7I2RR/lM2II8lJU=;
 b=q5c9U1+XyhBRj670mFmMrjKdZsE7uL8Sxyad2a6vyFoONVBU5qEZ/uq4B2iE6LWrjMs0CwW/AsJ9nWI9dxvB7sh0+hlYqTDgZP4Tkka7F7tgxfI7Wp6wf3Z883IjUul46hUlLWGClDr2mRIt63jRG5ldevJo0AWynG6Xv/AMJrI=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR1001MB2119.namprd10.prod.outlook.com (2603:10b6:910:3f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Wed, 31 Mar
 2021 17:45:31 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5%11]) with mapi id 15.20.3977.033; Wed, 31 Mar
 2021 17:45:31 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Parav Pandit <parav@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] IB/cma: Introduce rdma_set_min_rnr_timer()
Thread-Topic: [PATCH for-next] IB/cma: Introduce rdma_set_min_rnr_timer()
Thread-Index: AQHXIXfEcjVZJS51L0umIr0ZkYgnuKqdMUWAgAC/ogCAABcagIAAEDKAgAAEsICAAAU4AIAAAFYAgAAUwYCAACcUgIAABzQAgAAA5QCAAAAwAIAAAckA
Date:   Wed, 31 Mar 2021 17:45:30 +0000
Message-ID: <C55F49E9-900D-43F5-9430-E62249B801E4@oracle.com>
References: <FF7812F0-B346-40A9-AC34-0D87CAB74753@oracle.com>
 <20210331120041.GB1463678@nvidia.com>
 <2A5F5B02-4745-4EC1-974A-DE089F9FBE2C@oracle.com>
 <20210331131525.GH1463678@nvidia.com>
 <111062EB-22A4-4AE3-A31B-498445D344A7@oracle.com>
 <20210331133518.GJ1463678@nvidia.com>
 <E76F07B9-F222-4D0E-889A-712502DE0376@oracle.com>
 <BY5PR12MB4322EB01D0A22E6806B6F195DC7C9@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20210331173514.GO1463678@nvidia.com>
 <2BA07D00-E144-4547-8F7F-77DB0C197706@oracle.com>
 <20210331173906.GP1463678@nvidia.com>
In-Reply-To: <20210331173906.GP1463678@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ba7c929-48e4-4872-c4b6-08d8f46cc772
x-ms-traffictypediagnostic: CY4PR1001MB2119:
x-microsoft-antispam-prvs: <CY4PR1001MB2119FCA6A113C8A5908C2414FD7C9@CY4PR1001MB2119.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q2wFEowubjtJFGpIEfcVmxzBbrECzFTK4XScLw+sWjT726W2Z7YS59Kx6PyyFTeavKo7X1W+6UmQlkJplXmyUkox3p9ZyzSgFLbfdw/zA0wjQtbCKBdbpbyDjGd5C54eq3ynlcIfTZBz2zK+2vYndGOu3SERtgbug71Jj0MtM6T7TS098ZE4/GdmDVeLig1N0Am+WEQblEgeIwM/ANUACMRy6UQxMC3ts2WOf8pA3SH0T3vZ4Jhlllw+Mn02Iv8p7oJYD09kioBmpOTL6Pyaw7wooCxngvBMvWKHRBEb2BVRONI22ePufKhcOWAbcgRIFalaYYY7y/MNTihLK4rG1qEZfipgv95LbUJdHpUq2yYfC4paKxH1aCOUYkxb1gAbBy2Gvd6eJr+994CBH2u+54Uh8KxIqsYw8xN1HpuDHTeHRcPDF9K79T6HGh+Yx0We/N5MoH8g9z0BLwngBvJIn6dg6PWRSkRSR4MGxqLq+oBMYH5L3JlMdTkJK4oXv/Ul6O1W9dV7XDb57xSZzjOu0evw4xewNSZG2ao3qPh2K2zcvV05H3NCTiNbQVjc1FkPUgFjqrxlJX6P6xUQ4dRQt3rb28K6xDc2ryy6zicbFQL9qT63udqq0kcc2YJkPCUDWrTBTIUreV7L+SV0OAuuaQhKyDd42sd5SGoWUu1Ei/pmlIgpVZDAY4nSeoPke/OS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(366004)(136003)(396003)(478600001)(316002)(4326008)(54906003)(38100700001)(5660300002)(6512007)(33656002)(66476007)(91956017)(8676002)(186003)(66574015)(66946007)(44832011)(76116006)(26005)(64756008)(36756003)(66556008)(83380400001)(53546011)(2906002)(6506007)(8936002)(71200400001)(2616005)(6916009)(6486002)(66446008)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dzFIc1o1b1UvWVE5YndMN2V2cFRQZGFhWHJBN2UrL1RjWlFLdnY1YXl1NmN3?=
 =?utf-8?B?K0FoYmRoR1AvRk5SY2lsS05ra2VyelNrM1JtdVFab21TTys2d09zZlFRYlBl?=
 =?utf-8?B?eHEzYUFTVFd1QmNJNThKWXNLR3JzY3M1OEZ0eVM0bTZyaXRkSkFGM2svN3Ra?=
 =?utf-8?B?dGpWZjQxclNYY2NGZlVGTzFucGZmdW5mZitkamIzWmRWZXkwZmo3REpqSVJZ?=
 =?utf-8?B?SXJDWXVGKzMrL2lpbFZFWnJSbW5VbFk1UUZLc0d5MkFHMnNYQVBtMUZWdDRU?=
 =?utf-8?B?UjBXcFA1MXFPS1h2ek9UeGR1VUtSRXRHVFNrcVlkdFlzcEY3QnVrVE5ySVUw?=
 =?utf-8?B?NWlZMXlUenpqU2JPbUlhRjR1b3NQNU0zVU8wMnM0WUhEWEV1TUtpWURHa01I?=
 =?utf-8?B?VzlnTzE5U1FHWGVkek5ScWJUa1MzUkh3QWQyd1RuTEFSQWRGVmdQZkVkTURP?=
 =?utf-8?B?S2p6dGVPMHh3ZnpyanVYN3AreWcyMm1kdmVGVjVLYkIwbmpkbTd0anVoSmZU?=
 =?utf-8?B?SWY2UlNxclprZmR3a1Uza2x6YS9DYlo0Z3RURXhhclozY05QQU96QnYrNXhX?=
 =?utf-8?B?SUJhUmYyYjhnLzkrb1Nta0tCZUpPVnlScTErOURaekhOWmZXcldaMlNHNmhS?=
 =?utf-8?B?T2NkcnI0VGtsY3E4NjNocmhhaG9ybmZpc2djb2crUEdyenVaN2tsWmJSWXhY?=
 =?utf-8?B?RUtmcVQ5YUpqTlh3eVRkMFZEeEFXeWhMZ2xVWGo0czVDMWtCOWNzQlBCZzZL?=
 =?utf-8?B?TTZRdDBuQjVFSnc3OU03U2w5R3lnRTBjNUNVVCtPdzBvc3dKYU5neWk0MnA5?=
 =?utf-8?B?dml6eThFRUFISlV5cnJ1czN5WTRNbDZJV0RzQjdrQ3FQak0zQnBaQ1BHRElM?=
 =?utf-8?B?YVl5QXVRcWNNeUVGNjR6ZUlTL29hb1c2WS8ycFBxbkVKb3FOd0s2OTFYK1lI?=
 =?utf-8?B?WnBxdmY0SGFTVmQ1dEtIcVhJT1B6c2VpeHVvaW5XaUMrU29VdzcvS3lkd3F6?=
 =?utf-8?B?UGNLWi82aXdTODkrOFBvUnRNVkhnVDhpZUhRVnhBSXJYQUh0aUJGc0svTXFH?=
 =?utf-8?B?QTdwNi9TZU95OGh3OTRldjZMVmJKSGlERXRHNTRPN05Pazc5SlVNOUxheFZJ?=
 =?utf-8?B?cFlkd0xSLzY0alhnY3J6V0xQaTNRd29kVHV4N2FaNXVBMEFJcCtqOS81b0Nv?=
 =?utf-8?B?U05JOG14ME9HOFZ2ZGpabWVCMmdqYU4zMUsrTGQ5ZVhRR0U4TnB0YUtLQk0z?=
 =?utf-8?B?VSt0K2RvSy9hbXN2OUlJUUd0VUQzSVNGS2lRVGg4ZHJ6VnFQZnowTGFmNVRz?=
 =?utf-8?B?L1cwVUZHOW1iVHNWNkVhRU9TdEhHQWxZdU9IZVlWU215OWdGQitPblA1Y1JG?=
 =?utf-8?B?WDdLUGFkSFNSQW5SZlFHZC9NbXkrWHBwMW1BQ1Nwbkw5MkVEVWtvNWh1SU1m?=
 =?utf-8?B?QkJ4ckZ0YnVna1UvWHRnbTRWdk1tQi9sMHc2MWJGUktoaVlvQ3ArV2dNQnlV?=
 =?utf-8?B?WnFnNldPbThqclFNdDAwaGVMY3lMV0NqNlZwMjJWbCs2U2RES2J3Q20zUWwv?=
 =?utf-8?B?Q0pqMlErVlFsR1NaRHg5U2pnM3JpUERKbWxuVmorOEQ4OURkd0RqSWs1ZTkv?=
 =?utf-8?B?SVFiU1RlbFZCZGtvdGRPM3N5VXR0ZUxVMmhRRGpvZW0zVkR5RDREcTJDMzVD?=
 =?utf-8?B?Sy9NbFFUd0RvTWJBb2YyVmJTQUVEUDFKK0hRNjU0OHBvTHpUWUNTbGM0eGs3?=
 =?utf-8?B?WW50b1poNzV4d2lFUnFTNnJCV1hNdnhOKzNqWW1SQmR3MUZrRFRSaThRR2Jr?=
 =?utf-8?B?YzByYnhyK0ticFFEdFI2dz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0C6242BD9AF7441AA3A71A81400A4FE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba7c929-48e4-4872-c4b6-08d8f46cc772
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 17:45:30.8989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wr63UCQxqr4cmZEM1P3GAJ62PDy13u+My0iU8o0HvXIBpK6AAKOe4xgYjwkYZiCON3sxuPr3/TANrqPFa7TncA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2119
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310122
X-Proofpoint-ORIG-GUID: 5f-UCAZmDYQs2S2FN3NWRQOnOQi6BpLF
X-Proofpoint-GUID: 5f-UCAZmDYQs2S2FN3NWRQOnOQi6BpLF
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 clxscore=1015 bulkscore=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310122
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMzEgTWFyIDIwMjEsIGF0IDE5OjM5LCBKYXNvbiBHdW50aG9ycGUgPGpnZ0Budmlk
aWEuY29tPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgTWFyIDMxLCAyMDIxIGF0IDA1OjM4OjI2UE0g
KzAwMDAsIEhhYWtvbiBCdWdnZSB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gMzEgTWFyIDIwMjEs
IGF0IDE5OjM1LCBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPiB3cm90ZToNCj4+PiAN
Cj4+PiBPbiBXZWQsIE1hciAzMSwgMjAyMSBhdCAwNTowOToyN1BNICswMDAwLCBQYXJhdiBQYW5k
aXQgd3JvdGU6DQo+Pj4+IA0KPj4+PiANCj4+Pj4+IEZyb206IEhhYWtvbiBCdWdnZSA8aGFha29u
LmJ1Z2dlQG9yYWNsZS5jb20+DQo+Pj4+PiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDMxLCAyMDIx
IDg6MjAgUE0NCj4+Pj4+IA0KPj4+Pj4+IE9uIDMxIE1hciAyMDIxLCBhdCAxNTozNSwgSmFzb24g
R3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4gd3JvdGU6DQo+Pj4+Pj4gDQo+Pj4+Pj4gT24gV2Vk
LCBNYXIgMzEsIDIwMjEgYXQgMDE6MzQ6MDZQTSArMDAwMCwgSGFha29uIEJ1Z2dlIHdyb3RlOg0K
Pj4+Pj4+IA0KPj4+Pj4+Pj4gQWN0dWFsbHkgSSBiZXQgeW91IGNvdWxkIGRvIHRoaXMgc2FtZSB0
aGluZyBlbnRpcmVseSBpbiB1c2Vyc3BhY2UgYnkNCj4+Pj4+Pj4+IGFkanVzdGluZyByZG1hX2lu
aXRfcXBfYXR0cigpIHRvIGNvcHkgdGhlIGRhdGEgdGhhdCB3b3VsZCBiZSBzdG9yZWQNCj4+Pj4+
Pj4+IGluIHRoZSBjbV9pZC4uID8/DQo+Pj4+Pj4+IA0KPj4+Pj4+PiBUaGlzIHdpbGwgZGVmaW5p
dGVseSBub3Qgc29sdmUgdGhlIGlzc3VlIGZvciBrZXJuZWwgVUxQLCBlLmcuLCBSRFMuDQo+Pj4+
Pj4gDQo+Pj4+Pj4gU3VyZSwgdGhhdCBtYWtlcyBzZW5zZSB0byBoYXZlIHNvbWUgcmRtYWNtIGFw
aSBpbi1rZXJuZWwgb25seQ0KPj4+Pj4gDQo+Pj4+PiBMZXQgbWUgc2VuZCBhIHYyIGRvaW5nIG9u
bHkgdGhhdC4NCj4+Pj4+IA0KPj4+Pj4+PiBGdXJ0aGVyLCB3aHkgZG8gd2UgaGF2ZSByZG1hX3Nl
dF9vcHRpb24oKSB3aXRoIG9wdGlvbg0KPj4+Pj4gUkRNQV9PUFRJT05fSURfQUNLX1RJTUVPVVQg
Pw0KPj4+Pj4+IA0KPj4+Pj4+IEl0IG1heSBoYXZlIGJlZW4gYSBtaXN0YWtlIHRvIGRvIGl0IGxp
a2UgdGhhdA0KPj4+Pj4gDQo+Pj4+IFRpbWVvdXQgdmFsdWUgZ29lcyBpbiB0aGUgQ00gcmVxdWVz
dCBtZXNzYWdlIHNvIHNldHRpbmcgaXQgdGhyb3VnaA0KPj4+PiB0aGUgY21faWQgb2JqZWN0IHdh
cyBsaWtlbHkgY29ycmVjdC4gIFRoaXMgcmVmbGVjdHMgaW50byBjbSBtc2cgYXMNCj4+Pj4gd2Vs
bCBhcyBpbiB0aGUgUVAgb2YgdGhlIGNtX2lkLg0KPj4+IA0KPj4+IEFoLCB5ZXMgaWYgaXQgZ29l
cyBpbiB0aGUgd2lyZSBpbiBhIENNIG1lc3NhZ2UgaXQgaGFzIHRvIGdvIHRvIHRoZQ0KPj4+IGtl
cm5lbC4NCj4+IA0KPj4gQnV0IGRvZXMgaXQgZ28gb24gdGhlIHdpcmU/IE5vLiBUaGUgUk5SIFJl
dHJ5IHRpbWVyIGlzIG5vdCBwYXJ0IG9mDQo+PiB0aGUgbmVnb3RpYXRpb24gd2l0aCB0aGUgcGVl
ci4NCj4gDQo+IEkgdGhpbmsgUGFyYXYgd2FzIHRhbGtpbmcgYWJvdXQgdGhlIElEX0FDS19USU1F
T1VUDQoNClRydWUuIExvY2FsIEFDSyBUaW1lb3V0IGlzIHBhcnQgb2YgQ00gUkVRLiBCdXQgdGhh
dCBtYWtlcyAyYzE2MTllZGVmNjEgKCJJQi9jbWE6IERlZmluZSBvcHRpb24gdG8gc2V0IGFjayB0
aW1lb3V0IGFuZCBwYWNrIHRvc19zZXQiKSBmdXp6eSwgYXMgaXQgY2xhaW1zIGluIHRoZSBjb21t
ZW50YXJ5OiAiVGhlIHRpbWVvdXQgd2lsbCBhZmZlY3QgdGhlIGxvY2FsIHNpZGUgb2YgdGhlIFFQ
LCBpdCBpcyBub3QgbmVnb3RpYXRlZCB3aXRoIHJlbW90ZSBzaWRlIC4uLiINCg0KDQpIw6Vrb24N
Cg0KPiANCj4gSmFzb24NCg0K
