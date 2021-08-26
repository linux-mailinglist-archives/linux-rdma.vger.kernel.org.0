Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B57B3F8AF9
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Aug 2021 17:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbhHZPZ6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Aug 2021 11:25:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24520 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230203AbhHZPZ5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 26 Aug 2021 11:25:57 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17QExr9e014658;
        Thu, 26 Aug 2021 15:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Lu35c7Afsj4VIXJMLgDHHWmL4L4bkeSdxuThghCir6c=;
 b=ofYnD+ZMtIUeJ5QeAF+8g22xf8E6eKofn61WCKwadn/r19QHEPAjehX4uNqvGnmPSYhR
 6HDpteEl1L9cdrF/0xfl6qab20U5ZmcNg7l+GSlEo0ffiGP8Fl1J4OXxQcBWHqQPvnps
 J5+KlI37mgNPOyDlauiOYrhDUwK82mSaHl1oE3to3YdH1LU5VYcv5yEjWJbDbzkHdDGm
 qTGPZJSEa0cSRxdM5PAj9AaPaHYt+fldpuFYi+0zqeJGIDYl7ENYPPVRAreSoK5HuXxQ
 eYiunXErTLz5bYqZWqLRkIpXu71AZLVVqlUBjl8/n/ciad7r05eQLLc0nRKFfa9HPGxZ yg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Lu35c7Afsj4VIXJMLgDHHWmL4L4bkeSdxuThghCir6c=;
 b=UkOY5yaf6/mHijMbqAuzfgzQ+PydS7YQFkWbdU41+5XTqg5vQ2nP1GnTGLWshtTJqxXJ
 ckf6Ugf8MuZBFsagdktkpUXLAlPPX54Sz8eqN1m8n3ILdQywDpcpqimSX5mWmNjR8xBX
 T8WzanlbJozqn1DMAJD2Bv2IuOvm7Izy1jTr172sRC/n2yN1qmZQ2/uLAPi5u9xk+j77
 Ff/PnNxqPTB+wzyqH+w74IpLIzLMTx3E3KB1IhUB0ln40n3CI0CXYp700VnR1gqrM/3j
 xlX+W4sJykZLW9ztbVU0LcmzZv8A8lKJmRQfz5PDUBTCPMYF2cFbdAWIdmgJwy6JBHuf TQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap1r5hjcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 15:25:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17QF5iJg027025;
        Thu, 26 Aug 2021 15:25:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by userp3030.oracle.com with ESMTP id 3ajpm2rx3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 15:25:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFy6naawINv1qaL4q50L7xUIdGxwHQUGxSJ9zb5hZeG4Wdhj7uKf4PYgmxNF/6w28lQSvTfZYwZIOjBE6PpAf1US1jSwuTRWdL7IqPBItSzGDVnuUc71rcR/mG5wNBLMHyevG9BheQW7bUig22Kq+A9J1CBDGHmNK6VaPPJYLObJNW/srreF3AfG0WE1sHbDsk9MqKk1vjYNsrBN2kRoAovx7PbwZopk0CgvcLXz/Nbd6JOcgIvbUNBq5x4l6szDsixv1LSOCI3BNqbc2bS3/1McA81Q5YrwHqZ9DXc4w+6jaICYA7B7Kh6l+JIzOnX3hN7n5P6ZFPvfzpOFya+HPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu35c7Afsj4VIXJMLgDHHWmL4L4bkeSdxuThghCir6c=;
 b=Hz4ESqFM9WCov2deKeLehLy2/X9HAsFAvWiOn3jrNzrEZXH54g/mHuZyH5scVh1XOBaOEE/h2hgrDzxcUK/mdezlFd3eF4ZVEdtyq0mI7P+zhERUVqyzHO0wLkOp0625XkRi3izyRLu+pM8RiB1rEWdR9pmrFhbpmJ5Fa4EuELdgiU28Y+gKW6LEu+3KqUpKrD8+wH6FbKbwSw3SY3qqeRuLLOElVfWoi5Iv8e+Wrllz/jipNDJFSC51jkqnmDrmUE6FJ2ZXscxJOtSd9wCd7fflTm/uEIjthZoaWXMMPf81yMmbNuM9LsbtkD7oQPtcLGIWwcYs8t//5wWu0ULMtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu35c7Afsj4VIXJMLgDHHWmL4L4bkeSdxuThghCir6c=;
 b=lT9Za/96OC5m5GXfuZPTztsmytHSy1XN0tKD9wnzLjf9Mlmf1YcsbwrGORHfD1YvKjuI74v1c/ne4PBNUbS2Up78NjUFL0WR2oQqlZFdKD3Gk9ITZdcnX9wzjECfdX+wqL+pXiDImQT2fvhczScWC+ItiWg9LuJKLVNDRhgtqEM=
Received: from DS7PR10MB4863.namprd10.prod.outlook.com (2603:10b6:5:297::17)
 by DM6PR10MB2940.namprd10.prod.outlook.com (2603:10b6:5:65::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.24; Thu, 26 Aug
 2021 15:25:00 +0000
Received: from DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::496:2301:77d9:de82]) by DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::496:2301:77d9:de82%9]) with mapi id 15.20.4436.024; Thu, 26 Aug 2021
 15:25:00 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Divya Indi <divya.indi@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Kaike Wan <kaike.wan@intel.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v4] IB/sa: Resolving use-after-free in ib_nl_send_msg
Thread-Topic: [PATCH v4] IB/sa: Resolving use-after-free in ib_nl_send_msg
Thread-Index: AQHXmD+ApxeC7LUgeE645hjC9dbb76uEfC6AgAFwY4A=
Date:   Thu, 26 Aug 2021 15:25:00 +0000
Message-ID: <87E23BD6-857D-4A87-93EF-D2098535F997@oracle.com>
References: <1592964789-14533-1-git-send-email-divya.indi@oracle.com>
 <20200702190738.GA759483@nvidia.com>
 <d078d705-9930-7abd-84c8-9b7d41aad722@oracle.com>
 <20200708011227.GM23676@nvidia.com>
 <842DBB6A-9563-4629-B829-329DD344284E@oracle.com>
 <20210825172629.GJ1721383@nvidia.com>
In-Reply-To: <20210825172629.GJ1721383@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d855d17-8857-4d7d-e479-08d968a5ab9b
x-ms-traffictypediagnostic: DM6PR10MB2940:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB2940C4472F02DB3D76003220FDC79@DM6PR10MB2940.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yI45dFblnRqGj8p01vyGlUHtlUmu9ldG1kUj4M+G3n5sA3RMswdgPIttGnkM7ToBAh/TH2Rpl+a7MgAAPMtes67JglYprVM03yqZSAfp8xEtJlQedtiR4s7LnpAU2uYcC/cSwXij3KtvppZ+NyevF9UL7JpxweiL7jsMidLoZ42cQDfMVhneIKfmfTxxZQHucgJVtneYvrZZ6EOXFIq3xuY51q8BgfEfna0RGRpHz5J/hjPdoFp3GDy1xD9LRMyVbPlrq3lqPJ1bFYZMrx3ZYJUWo2tuN7Xn3fKEESPvmEAh0bBxFI16fI2aTWuCv2cTy8V9CbMTXBrT5/EcqaqaDo+v8DOdpJ2zpK0M8PDNoZ1wlWOS9g2j838oHLrj7TXPljUYv+kVJOgS/LCVz1G1HBGjY1LBeWIIVZVURfnAtnk0dSpLRBbIuQ82unZJqAKc1GPE3qSnU5mio08a+/OGNn66Y7F00rDTfwZv5cHPu73mQHQavFP4OTPK5A3wg3FhpLZa8yT+TVgYDxqIO6fAdLEtszfxDDiXdNOenoHqSOgvfs4iR+QCUP+x13JYuRN1D/GkwV/5DF1Dem6e5h2jJb2SiiLNmN4usa6xwbIb1VuOGRpcWknbaqF7c9v4sGwW7BJIkzTsC/qa0RmWmpNPyuotSUeMY6DC30KK0a+7+M4OV2E8J/wDgZOJicp1z4TPgZKyK5XpKqzOYGYAuhILQ6C7HOqSTQ7osHlV5dVFUGEUaW+UVt0Vtpr/UAbgQRsxI4jQWNkbEcZC/QSkiIiMtugrAFoXofJ2YtFyPCzFXY3oXUo6x83lCiDU/knf/MzT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4863.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(346002)(376002)(136003)(44832011)(38070700005)(4326008)(2906002)(966005)(6916009)(36756003)(186003)(26005)(2616005)(8676002)(6512007)(8936002)(91956017)(76116006)(66446008)(66476007)(122000001)(478600001)(64756008)(66946007)(38100700002)(86362001)(83380400001)(66556008)(54906003)(66574015)(6486002)(6506007)(53546011)(71200400001)(33656002)(316002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVArMy9VdFJlL0Vhb0d3eW10ekNFaG4xbGp5QTZ0U0Z0T0lpZ1hKUzNBTDVj?=
 =?utf-8?B?ZE42bFdPaXFudlZTQ2hNUFlITWRpSHhOLytoR1FQVEJBaytiZWNlazRYL3JT?=
 =?utf-8?B?SnAxcVpHOFRrNDNXdFJZcWd2NEhVZ2l4Vzl5c1drd2ZSTzFwVzdFbVAxdzhX?=
 =?utf-8?B?eVV3WlZpbllPZ3kwUDQvdEJWaTUrNUJSQ1k1Yk9VSk9BQ3FXc2ZwVkk3dU9Y?=
 =?utf-8?B?MU1OVndNeFdnZFlVdjdoNUNGdjJ3WWRhZjBjbUFuTVBmK05DVlJmdTc1Mng4?=
 =?utf-8?B?S1I1S0JoNG1ZdGdTWGk1RE1hV3p3OWNjeXFQL3F5OXdTS2VUY3ZLS2lRN1NS?=
 =?utf-8?B?ZzdObzIyNGtNQXYxd2ZzVEtQQmJPb2lVNno0ZjljSEY5Ym5HVEZ3akVueTh4?=
 =?utf-8?B?dE1aYXh2SjRTYlBJUVRmdTNHMVA3RG5MM1dGSHZ1MkF0VTl6NG42Z0hTaHRD?=
 =?utf-8?B?M0xlRHh4TnpwNXFTSTNGYkVHcGlnTlhFU0Zoa21qa1NDRUZnZ05FSnUxZWx3?=
 =?utf-8?B?SG1LTWw0cng2UWJ3UytzYTBmeFZON3pNMnVJemxPY0thUDNaV003Q2ErSUtj?=
 =?utf-8?B?eVlDcXZ4ZHh4SkVrSlJUZ29MZURsaGh1aWY4UDZYSWo2Vk5mVWVwVm9LYnZS?=
 =?utf-8?B?WVN0N3pIZFdROXgrMDNOUWNQb1NwWE9EdHRFRW00OVBYM3p5cFVLQ1h0MmtS?=
 =?utf-8?B?MnIrTWFaa05TRnRQWU01R2EyQzdJbW5HMnE3aTFkVXFlZVFMcUFKNGhPa3ZL?=
 =?utf-8?B?MGhESkZQOUdmY0tKT2ZIOG9XQU93eEtRNnk3UjBlV3dMOEhkb3lRbWVrR2t6?=
 =?utf-8?B?QWtTaG9aOUFLZVJsd3VUSUYwYlZsZzhNaGdFWlNkZFVxSUNyMXJrUEg5Y3B0?=
 =?utf-8?B?NW5maDJoOTNVVlF2b3FxNTNqM3V6M1hVRnErY3RJRG5UdE5jVW9HNW11Zzd3?=
 =?utf-8?B?VFRrMTdJazlWMVpnWHRETm1tNUZKTU9sVnlqUkRxazBxVzNPRnZaa1d5a0V3?=
 =?utf-8?B?WVNBNjNPRC9INm9iZExNZVJ2cjBEaGVoeGRnb2NsYTJBZ3o5VjdhcXlPVStm?=
 =?utf-8?B?UDViWjkwc1pOWUpTMFpIc2o4c013eHpPWUxSV1c1SzlrUWR1K3k5ZUFlS2My?=
 =?utf-8?B?a296L3ZrQnRDSTJNMEJGS0hZR2F6TkJFRGFqaVZQUlQrUFFOa3A0TzlpZWw2?=
 =?utf-8?B?WGpqblozYWdBSGNJd0FRR0c0cmhsaDVUTkg0V2UxeUY2eXNndStWR243QzZj?=
 =?utf-8?B?NnJ4dE5vRVJLbGd3VWVFOGI1U1I1WlFzTlcxQ2JnWkZKb1lvYk5Xb1ZpVlFV?=
 =?utf-8?B?YnlPMXU3Nkd3cEllQlo5dndleS9FVkc4d0t3azgvdjFnQWlTVE43WFRnYjBI?=
 =?utf-8?B?WHE1Y3BUMUxzd0Q1MDVlcFh0Q01KdmF3aGZxNktGY09oR3k5aHViNkJBNzVB?=
 =?utf-8?B?K2ZPSWFkK2xySWlncENVZTRWN2VKVmJDODN2bDh5OTJCWkRQdGxhZXJXRnVv?=
 =?utf-8?B?Z0d3UE5UQzM4THkwbzY4VXdMZXpPVVpHT3FLcnQrMGg5Q3NLeFJtK2NrOVBT?=
 =?utf-8?B?bzBlS2ZsdzNRb2kzYnVSQ3JBb1ZuUHhjNnIrTi9sQXptT3JLbnVIeTAzYk52?=
 =?utf-8?B?TzlZM1FyaVhoU1VNM1VRMU1HZzZTVWF0SlpGSGpsNkt2UmdZYnVJS3hVYWFq?=
 =?utf-8?B?K0hFMmwvcHRjUERNcTBBMEhYYWdxcnN6SWFqMEl1NWduTWQ0SmRNSlVQR1Av?=
 =?utf-8?B?bVZjT08xMzlVQ0tDc3d5K1MyaER1MVVXaWxrS3VJRzA4cnNOZmsxQzZYaThh?=
 =?utf-8?B?cXlRcUEzU2FHUE9uL1dYdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7CB4184ECEC03488B815076BF0552E6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4863.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d855d17-8857-4d7d-e479-08d968a5ab9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2021 15:25:00.6384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SHhrKQQacRRh0+XUVW8gBUkyM762QCuujn0DEEu5VEjCybtiA1qQm5hHoixfmxtfDHtuKpykd4Va0tm+bl2L0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2940
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108260087
X-Proofpoint-GUID: 0XTzvxMG6dujT-GRn8K40Hi-4Q0oBMCM
X-Proofpoint-ORIG-GUID: 0XTzvxMG6dujT-GRn8K40Hi-4Q0oBMCM
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjUgQXVnIDIwMjEsIGF0IDE5OjI2LCBKYXNvbiBHdW50aG9ycGUgPGpnZ0Budmlk
aWEuY29tPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgQXVnIDIzLCAyMDIxIGF0IDA0OjU0OjE2UE0g
KzAwMDAsIEhhYWtvbiBCdWdnZSB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gOCBKdWwgMjAyMCwg
YXQgMDM6MTIsIEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+IHdyb3RlOg0KPj4+IA0K
Pj4+IE9uIFR1ZSwgSnVsIDA3LCAyMDIwIGF0IDA2OjA1OjAyUE0gLTA3MDAsIERpdnlhIEluZGkg
d3JvdGU6DQo+Pj4+IFRoYW5rcyBKYXNvbi4NCj4+Pj4gDQo+Pj4+IEFwcHJlY2lhdGUgeW91ciBo
ZWxwIGFuZCBmZWVkYmFjayBmb3IgZml4aW5nIHRoaXMgaXNzdWUuDQo+Pj4+IA0KPj4+PiBXb3Vs
ZCBpdCBiZSBwb3NzaWJsZSB0byBhY2Nlc3MgdGhlIGVkaXRlZCB2ZXJzaW9uIG9mIHRoZSBwYXRj
aD8NCj4+Pj4gSWYgeWVzLCBwbGVhc2Ugc2hhcmUgYSBwb2ludGVyIHRvIHRoZSBzYW1lLg0KPj4+
IA0KPj4+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Jk
bWEvcmRtYS5naXQvY29tbWl0Lz9oPWZvci1yYyZpZD1mNDI3ZjRkNjIxNGMxODNjNDc0ZWViNDYy
MTJkMzhlNmM3MjIzZDZhDQo+PiANCj4+IEhpIEphc29uLA0KPj4gDQo+PiANCj4+IEF0IGZpcnN0
IGdsYW5zZSwgdGhpcyBjb21taXQgY2FsbHMgcmRtYV9ubF9tdWx0aWNhc3QoKSB3aGlsc3QNCj4+
IGhvbGRpbmcgYSBzcGlubG9jay4gU2luY2UgcmRtYV9ubF9tdWx0aWNhc3QoKSBpcyBjYWxsZWQg
d2l0aCBhDQo+PiBnZnBfZmxhZyBwYXJhbWV0ZXIsIG9uZSBjb3VsZCBhc3N1bWUgaXQgc3VwcG9y
dHMgYW4gYXRvbWljDQo+PiBjb250ZXh0LiByZG1hX25sX211bHRpY2FzdCgpIGVuZHMgdXAgaW4N
Cj4+IG5ldGxpbmtfYnJvYWRjYXN0X2ZpbHRlcmVkKCkuIFRoaXMgZnVuY3Rpb24gY2FsbHMNCj4+
IG5ldGxpbmtfbG9ja190YWJsZSgpLCB3aGljaCBjYWxscyByZWFkX3VubG9ja19pcnFyZXN0b3Jl
KCksIHdoaWNoDQo+PiBlbmRzIHVwIGNhbGxpbmcgX3Jhd19yZWFkX3VubG9ja19pcnFyZXN0b3Jl
KCkuIEFuZCBoZXJlDQo+PiBwcmVlbXB0X2VuYWJsZSgpIGlzIGNhbGxlZCA6LSgNCj4gDQo+IEkg
ZG9uJ3QgdW5kZXJzdGFuZC4gVGhpczoNCj4gDQo+IAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiAN
Cj4gCXJlYWRfbG9ja19pcnFzYXZlKCZubF90YWJsZV9sb2NrLCBmbGFncyk7DQo+IAlhdG9taWNf
aW5jKCZubF90YWJsZV91c2Vycyk7DQo+IAlyZWFkX3VubG9ja19pcnFyZXN0b3JlKCZubF90YWJs
ZV9sb2NrLCBmbGFncyk7DQo+IA0KPiBJcyBwZXJmZWN0bHkgZmluZSBpbiBhbiBhdG9taWMgY29u
dGV4dC4NCj4gDQo+IHByZWVtcHRfZW5hYmxlIGlzIGltcGxlbWVudGVkIGFzIGEgbmVzdGluZyBj
b3VudGVyLCBzbyBpdCBpcyBmaW5lIHRvDQo+IGNhbGwgaXQgZnJvbSBpbnNpZGUgYW4gYXRvbWlj
IHJlZ2lvbiBzbyBsb25nIGFzIGl0IGlzIGJhbGFuY2VkLg0KDQpZb3UgYXJlIHJpZ2h0LiBBcyBJ
IHNhaWQsIHRoZSBzdGFjayB0cmFjZSB3YXMgZnJvbSBhIFVFSyBrZXJuZWwuIEl0IHR1cm5zIG91
dCwgSSBvdmVybG9va2VkIGNvbW1pdCAyZGNlMjI0ZjQ2OWYgKCJuZXRuczogcHJvdGVjdCBuZXRu
cyBJRCBsb29rdXBzIHdpdGggUkNVIiksIHdoaWNoIHJlcGxhY2VzIHNwaW5fe2xvY2ssdW5sb2Nr
fV9iaCB3aXRoIHJjdV9yZWFkX3tsb2NrLHVubG9ja30gaW4gcGVlcm5ldDJpZCgpLg0KDQpUaGlz
IGNvbW1pdCBmaXhlZCB0aGlzIGJ1ZyB1bi1pbnRlbnRpb25hbGx5LCBJIHdvdWxkIHNheSEgU28s
IHRoaXMgYnVnIGhhcyBiZWVuIHByZXNlbnQgaW4ga2VybmVscyB1bnRpbCB2NS41LXJjNy4NCg0K
U29ycnkgZm9yIHRoZSBub2lzZSENCg0KDQpIw6Vrb24NCg0KDQo=
