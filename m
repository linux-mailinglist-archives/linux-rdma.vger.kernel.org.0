Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D211408B58
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 14:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbhIMMwX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 08:52:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33930 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234945AbhIMMwX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Sep 2021 08:52:23 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18DA1Ldi028508;
        Mon, 13 Sep 2021 12:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ewxukHft1XR9qsw4NO5NR2SNWxKKcpXF27py77EncV0=;
 b=vqQtUfjjCZPidTzQRxJqeiBUywEf+kShl10jSFzBPGpYctrDsx9d5EqMNufB08bsxZJY
 yiTMOPRPIHsj2Y9RcxNtbBKXA2GRQJ0S9KtA969RviW4hkqjp26r/37RES5wE5l1TCYG
 FJgWB5EZlB3zlJD5rWxvwct1ZaEywqjiXbqvEPRnAELigbuAMxfj+mThHH/eMQkDbOuL
 JdgSk0Z2z13Z3J/no7q8uaZP1PTDh5QoVZHJ8YdxDZP/gKhZ7vpNGVyK+8hrwu5z9Mg8
 xZx//RDwhDN3Ltk0tqjS/O0KaweVf+J88UPWIKtrx9gkue3EGb3LnjF0GuQM/kamwRIV 3g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ewxukHft1XR9qsw4NO5NR2SNWxKKcpXF27py77EncV0=;
 b=mZUfdtSBWvWp/7/WP/9Ca60zlW/MTqLNszM2RmUb/UxDb1ZNkw8xFyFiAek7NMx4B1yZ
 5AOZf0K0k9POB4RpPbD/Ktk97FJlICSmgMzoSb20U+UNCoWuD2+O9sL84vaR+nYXrl0E
 4o9Z/zKvtC/L2YUjEARneTNLnICzR4Sbho1cOJcxfo6rP71ANRDk/t3GSdKy64PaUn/Z
 0Ti8RXvFvid7dplhimURsQhEI2oTKhZbr/UwzN6LG9K2ogx9xkFJzx0HR9L+WGhGy1a/
 ZOA85IHy4JcfUZV7bqsIlf9XygEv1ErUJfK6gUGHhfcBbey9L1QZfsxMQdMs2xlPOM9l dQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b1ka92d0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 12:51:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18DCjMVi056016;
        Mon, 13 Sep 2021 12:51:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3020.oracle.com with ESMTP id 3b167qcwr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 12:51:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLKQRtbuVdw2ULUKWzRtXz6nMpmcBJ6eBRYVPMuFv/LB+JshQyq5g/psTbsPZivkOgI0I5N+JdnwHThrhdLMoTEnAAqYLW9y4ZTp92OAcQ+VXTc+s/Cu2Kvm55xHObX6yv95SiU+YK2M0/IQ5Libea18wxrrnaJcM8RiCu4L0AhheWhx2C5tZg/COPI42XEAaXYhO1AvT8dtTiYiYc9gV5akRoM80X1W4Sz+ltyl/yGp9m8APpUPsBHNzauKG/m1fk0+1N+IU7osuo9FXgU6KP9EB7SBqrPLTeBvyV2Hkqr0OuAo9CnTpVV3TS8jreJqb8up21RH+slmpDJ+nvukrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ewxukHft1XR9qsw4NO5NR2SNWxKKcpXF27py77EncV0=;
 b=Hrhxmveo/rDK9dRNcfRgGwMgZu26Ff9dG7deSzcLYUDoMh3R/6myLQkThXjYA48Uh7VrEP1sjD5yaa2d2nWsTcj0mcM6arTNYNzMptpZOKGQRhUvQc66DhiZ2p0D/nbJgEDg3Ctxb8cuIbWzg4D3EMZAep2rPOV/ywVJrPtROIYSbH2p2HlMW5nv1yMAtypbzVGwG211qQ2VBhnzskzduph3wqMmUcUZapOvLS8Fv6gZKkUhsLUcJK9oIiXkwpUYAna6fr8QWnXEhGZTndFc0f306SyLDZfsgBd4KyVrFlvcM/JYXZbEXPGJ5NGtNxwXnbW3ndfXKwDpv8/a715hVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewxukHft1XR9qsw4NO5NR2SNWxKKcpXF27py77EncV0=;
 b=EkaNOyuNyebYHMlQrCduoYVS4R/Bf8lcI75Nxf3UeBJF5ExXAczITsXLf4Dp/TmNK3woGo4GxDWdNuGzkOcUdHHN6Y2/hzBtJt4oLqGz5KfLPQlut7lJz6dnYlY02A3qu/nAj6C42Rta7tW8eGFFlxrEMvF5ZaHTF/t6EFfDNDA=
Received: from DS7PR10MB4863.namprd10.prod.outlook.com (2603:10b6:5:297::17)
 by DM6PR10MB3980.namprd10.prod.outlook.com (2603:10b6:5:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Mon, 13 Sep
 2021 12:50:58 +0000
Received: from DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::847d:80e0:a298:6489]) by DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::847d:80e0:a298:6489%7]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 12:50:58 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Nelson Escobar <neescoba@cisco.com>
Subject: Re: [PATCH rdma-rc] RDMA/usnic: Lock VF with mutex instead of
 spinlock
Thread-Topic: [PATCH rdma-rc] RDMA/usnic: Lock VF with mutex instead of
 spinlock
Thread-Index: AQHXqHYVzpw5iH5J6U2iOHiH9rCYa6uhnoWAgAAC3ICAAEmwgA==
Date:   Mon, 13 Sep 2021 12:50:58 +0000
Message-ID: <AC729233-CCB2-4A90-A7B2-08E534C3B1F1@oracle.com>
References: <2a0e295786c127e518ebee8bb7cafcb819a625f6.1631520231.git.leonro@nvidia.com>
 <ADF1D118-A29D-4B32-9D25-F3B1768C8924@oracle.com> <YT8LYZvhYm/kT7Kb@unreal>
In-Reply-To: <YT8LYZvhYm/kT7Kb@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62d7ffc6-9d27-405c-c059-08d976b52269
x-ms-traffictypediagnostic: DM6PR10MB3980:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB3980BEBB42D79656E4A1E4E6FDD99@DM6PR10MB3980.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BquddO/9UP4o539OqVb8xLniv5nPA+wLgRV/Dm5KZB6+/EYo7EgIP5wLgrHnvfat7gN1uVlCHUfFJqAtx9oLdaVtJ+i/yT8yO1WZISmZojGo4BkSXiCLwuaRfh/ThfAB1KdM6u8VWgylfTI9yJCnP3He5vzmEAQ/F2pEM54JQvDdv+2TyoCL6hVz7nPbQ2Q6sWsDqY+IBDfuCg8nzOqmDkF87M4JHpqy27y/7XSIeNFRvsn00klGBuoM2Y/7RHUTwHCUligU63XAzgC0Fy+blhMTCkQRa8qQ94L8kFtlzoivl0c5MDuvnglsTyYxke0J81vN8QIgJSGhceWqQy1XxhSu/t+u/zmC/516VfoBJhZmYaLT84as41CroQlKZaSmhBRZ0oLIWRBq3C69g33IEV3q2rte+I3oWR7LNK8o11Mz8aLGw3Baec6JLZIIor6I4PWPU4JTza37ERSLUlA0EeaS60m3+Z8q5zbKMmINifxTgEYgtjwDdwSX1GsAINZgS13f7Jb+4sNqz+jbqYreImnCfDwUoG5yh79lfi4tBN5Kj9v6AUGeAaZGdajwJxLMv2xJHToaCZ3QIMNa4qhXdzAcWt9r5+ziM0umodoCExctxAvJSdjALlgdh8+kYcjDFeB3JCxIeSJS2ay7iMTzLt5NKKos7gm+VDk/AwbZ33Sy/3868jfSLSOiig9Q66HegSSl8+xAAPuXcBOmjHVJVXmwb+baPP9EQ2vYmPVw0pq/y9YjnkB47Ah8XGD4s24A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4863.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(376002)(366004)(396003)(316002)(44832011)(6916009)(54906003)(76116006)(478600001)(86362001)(36756003)(2616005)(71200400001)(91956017)(83380400001)(66574015)(66556008)(64756008)(186003)(122000001)(66946007)(6486002)(8936002)(66446008)(66476007)(38100700002)(6512007)(5660300002)(38070700005)(6506007)(53546011)(8676002)(2906002)(33656002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlpTb2VhYWRCZVNhVjF0a2JpclpkcmNtSklENm1iRmhEclRYYTlmYTdhUXFZ?=
 =?utf-8?B?YXJuYXpJYUVHVFBWSFEyTEo1N2pTUkpZZ2pETk03akYrYWpYZzNXdkdJUlRN?=
 =?utf-8?B?WjZ6TDdFZDZxSUJnQXd4ajNyc3ZYWWE0NUdDT0NodHBSUnlqS0tId1ovS2F4?=
 =?utf-8?B?UlZvdmJPalhML2NZUWxMeUI4aFVhWHRyNWZLYlgzK2xmN1hnVXdXems1VDhL?=
 =?utf-8?B?R1BFWGozcnd1MlRKWnBkQUFaVDBiMFhKT0crMmhrSjVsbTI5eVlJUm5keEpo?=
 =?utf-8?B?VXhGUTlpN01KaU9pWk12bVlIMXp1YW9Eb1NXcG9OZFBYQ0NiTUlOQ1BNY0hP?=
 =?utf-8?B?N0hoN3FaSEFqS0c2bkpzSENQclNVZGE2MXdjT1RIV0FWOE1qWWhJZm9NTm5y?=
 =?utf-8?B?ZTI5YU9GejhvMlFBK2xqMWt5TkhkRStlTEc4VHRvUUlGUmhIQU5HMDI4aDRD?=
 =?utf-8?B?MjB1MDZhMXZ1MmdmelNESlMrYnJxdE84RXFxNi9UR0NFeEhFYVU0SmoyZExy?=
 =?utf-8?B?ckxrQm9WUHFuR1A4QlJwZ1JKV1hMd2dWWk5qT0hBdUFXMnVablduc2xvU3Mr?=
 =?utf-8?B?c1RWRkxOZ3Y3UjRLOWZTZVBtL2hiRzBkUHBqSUl5cUpUaEFuaWN5S2lEcXp5?=
 =?utf-8?B?RGkvanBiUjRXT21LQjhwWTk2Q21iTjB3ZU5QeW1sSnNDYTBGaWNDMjNIOVlT?=
 =?utf-8?B?Nllid3YvM1JrTmlSK3lNc29WUE5UMmM0RW9CWGZ3WE5QODEvMjllZmo2NHFO?=
 =?utf-8?B?S0lYdDBac1RFaVA1TmhNeXNXWDM0SEFTS3YxbHE3SGxQS2FRUG1WUUR4WGIv?=
 =?utf-8?B?M2luTWNsY3NvUmJabmdNNU5udkhFaTFZU0RUM0gvZWtnM1ZTOVQzYVBiZ1lu?=
 =?utf-8?B?SjlVMk1NTzIySW1UZTlJM2c4RnQwNDQ4NElFNW1IZ1RFWUIwOU93ck9KZWl3?=
 =?utf-8?B?VTRRRnJ1bjEvdG1uUzZyK21TN0k4c3dSTE5vS05EU2sva0I2dk9ENUZ1WG9N?=
 =?utf-8?B?OHkrdGsyN2lLdHdrcUYrOXMwUmZ0VzFsdHBEb05vaDk1OThBRFhYUVVOSTND?=
 =?utf-8?B?VVQ5SFZTQUV3dzlGWHNzWHd2RkVBSVRyeGhJQVBidDhObkdIanNhcFVQUlVj?=
 =?utf-8?B?eGEyWEg4eENkdjMzTEhkcHlRdExRVjg1bThxVFdDRU9WVWRYUDk2TnZMdzRy?=
 =?utf-8?B?WGhTQVppU2c0UUxMRTVZelJLWGFwQVFFYkxNL0d6Nk9LZms1ZngycFViKzY1?=
 =?utf-8?B?R1ErUFVLVmoxSmRud042dTZkbG90WmFaVWp3YVdOSEw2bzh3L3dSemRHd21t?=
 =?utf-8?B?WXZvR3didWExZDEwc0RiaGd3RkNqU09STkpqckNtNFhnZ0VwaTFGN2RmalVv?=
 =?utf-8?B?eStyd00yVG5DWjdKUFRMWHdNQ0QrdHc2enlNR1FWc243RFBOalk2M1k0MGpV?=
 =?utf-8?B?ZDVxRmVrVVJWQ3JyeGpuWGZtcjM1QzN0aWpicXJJSHNJRk5sa1JxMlA5U1hC?=
 =?utf-8?B?TlE3VTFtMFZGeVhiY2QwUkpreFdwUUFuZWc4elZaNTZ2ZU5GSkZDM3hSS1Ar?=
 =?utf-8?B?TGNRT2xHUnUzanFXck1CR2FEYUNSWk1jR01JNjhBK2FvZGhPSENnV3gzc1c5?=
 =?utf-8?B?enlBYWczQVRRelhKSnB2MDY4NmJ5aUNZK2puS1lBTDduM21wb2RZWThMYUh5?=
 =?utf-8?B?akIvWTNIVzdxREk1UmIzdUpMZHVWdUszejk1TyswRkt0ZFRpdVptYkw5amlp?=
 =?utf-8?B?NkZVZUZhclNtaHlCeUNmWGlIZmVrT0plcWdoaVZVSnF6b1o4Z2ZaYUVlV1Z0?=
 =?utf-8?B?TnFsVlg2NEo4UE5mMDU3WnZJcjIyeCtuOEFPUWZ1eG5SWm04UzJpOXVQZjJp?=
 =?utf-8?B?UUFGK3VqMTBaTW50aWF6Y3ArcFdXd3ROTWl4eDZQdGpVTnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A690E21D62E54241ADE9A9630C315F07@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4863.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d7ffc6-9d27-405c-c059-08d976b52269
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2021 12:50:58.7413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YPzKN0GfaWOyEE3s9TOVV0yyUXToFmoaOf7h4b8xm9K5IcIAGIHXV4KcMvUuOcOhq7oi0rn9VtQheOwAB6y7pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3980
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10105 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109130085
X-Proofpoint-GUID: 1PpPoIK4UhO3AWdp_OtdvB3BC6Sz8TnD
X-Proofpoint-ORIG-GUID: 1PpPoIK4UhO3AWdp_OtdvB3BC6Sz8TnD
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTMgU2VwIDIwMjEsIGF0IDEwOjI3LCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIFNlcCAxMywgMjAyMSBhdCAwODoxNzowMEFN
ICswMDAwLCBIYWFrb24gQnVnZ2Ugd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIDEzIFNlcCAyMDIx
LCBhdCAxMDowNCwgTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+
IA0KPj4+IEZyb206IExlb24gUm9tYW5vdnNreSA8bGVvbnJvQG52aWRpYS5jb20+DQo+Pj4gDQo+
Pj4gVXNuaWMgVkYgZG9lc24ndCBuZWVkIGxvY2sgaW4gYXRvbWljIGNvbnRleHQgdG8gY3JlYXRl
IFFQcywgc28gaXQgaXMgc2FmZQ0KPj4+IHRvIHVzZSBtdXRleCBpbnN0ZWFkIG9mIHNwaW5sb2Nr
LiBTdWNoIGNoYW5nZSBmaXhlcyB0aGUgZm9sbG93aW5nIHNtYXRjaA0KPj4+IGVycm9yLg0KPj4g
DQo+PiBzL0dGUF9BVE9NSUMvR0ZQX0tFUk5FTC8gaW4gZmluZF9mcmVlX3ZmX2FuZF9jcmVhdGVf
cXBfZ3JwKCkgYXMgd2VsbD8NCj4gDQo+IERvIHlvdSBtZWFuIGluIHVzbmljX3Vpb21fZ2V0X2Rl
dl9saXN0KCk/DQoNClNvcnJ5LCBteSBjb21tZW50cyB3YXMgdjUuMTQuMSBjZW50cmljLiBGb3Ig
bGF0ZXN0IHVwc3RyZWFtLCBpdHMgYWxsb2NfcmVzX2NodW5rX2xpc3QoKSwgDQoNCmZpbmRfZnJl
ZV92Zl9hbmRfY3JlYXRlX3FwX2dycCgpIA0KICAgLT4gdXNuaWNfaWJfcXBfZ3JwX2NyZWF0ZQ0K
ICAgICAgLT4gYWxsb2NfcmVzX2NodW5rX2xpc3QoKQ0KDQoNCg0KPiBUaGF0IEdGUF9BVE9NSUMg
ZXhpc3RlZCBiZWZvcmUgbXkgcGF0Y2ggd2hpbGUgd2UgYXJlIGhvbGRpbmcgdXNkZXZfbG9jayBt
dXRleC4NCg0KVHJ1ZS4NCg0KPiBBbnl3YXksIEkgcHJlZmVyIHRvIHRvdWNoIHRoYXQgZHJpdmVy
IGFzIGxlc3MgYXMgcG9zc2libGUuDQo+IA0KPiBUaGUgYWxsb2NhdGlvbnMgY2FuIGNvbnRpbnVl
IHRvIGJlIHdpdGggR0ZQX0FUT01JQyB3aGlsZSB3ZSB1c2UgbXV0ZXguDQo+IEl0IGlzIGJhZCB0
aGluZywgYnV0IG5vdCBhIG5lY2Vzc2FyeSB0byBmaXggYnVnLiBXZSBqdXN0IHdhc3RpbmcgYXRv
bWljDQo+IG1lbW9yeSBhbmQgaW5zdHJ1Y3Qga2VybmVsIGRvIG5vdCBzbGVlcCB3aGlsZQ0KPiBk
b2luZyBhbGxvY2F0aW9ucy4NCg0KSSBhc3N1bWUgdGhpcyBkcml2ZXIgaXMgbm90IHZlcnkgbXVj
aCBtYWludGFpbmVkIGJ5IENpc2NvLCBoZW5jZSwgSSBhZ3JlZSB3aXRoIHlvdXIgcmF0aW9uYWxl
IGFib3ZlLA0KDQpSZXZpZXdlZC1ieTogSMOla29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xl
LmNvbT4NCg0KDQpUaHhzLCBIw6Vrb24NCg0K
