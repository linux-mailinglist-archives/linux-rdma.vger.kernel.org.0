Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1425F35CACF
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Apr 2021 18:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240943AbhDLQHh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Apr 2021 12:07:37 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:39658 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239555AbhDLQHh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Apr 2021 12:07:37 -0400
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CFseI6007760;
        Mon, 12 Apr 2021 16:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=pgaEZBLBNOodMc/jljAc9E3PJ3hz2NrvU9CexjmAURU=;
 b=CSZbtfS7NLi8quQEEDEn8ZfUvLlWsiEcVN+1j6iX8jWTgLyAwxFKdHw4f4olLyrTPHXl
 4y9QAAT78RzypIXnBqgH8GSbL/shGUEh2C3uIYdewjTk9S+UG/kWbbdybLmIQK3vjlYh
 1fDswAbRDj8V6NloSn48rTZfh/Yu1ko/WIO71eSp+lo/kkVMHVVYGDgtTwZYgh09bZEh
 yN3nxWSOtG/mHD9Q/eabRJNOB4DvfMaUVHSu22DborzfhfoS1uO2EtmPwUtcD2C04qnN
 UTEcQrsW4SeY7IyMM0RWNY/e476QHAzV/FojKhgt5L9xIiIIVdhoWFf/7dZvcGsu6O0h rQ== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 37vrrq0d6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 16:07:16 +0000
Received: from G4W9121.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.210.21.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id E4915A7;
        Mon, 12 Apr 2021 16:07:15 +0000 (UTC)
Received: from G1W8108.americas.hpqcorp.net (2002:10c1:483c::10c1:483c) by
 G4W9121.americas.hpqcorp.net (2002:10d2:1510::10d2:1510) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 12 Apr 2021 16:07:15 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (15.241.52.12) by
 G1W8108.americas.hpqcorp.net (16.193.72.60) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 12 Apr 2021 16:07:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzQw7EWKcZI4uHX72AMiIfmpqdqbPAvgZ20PAo5CUmjvG6PhUNvUXzMW4qL1fEsqCEZrgMHNtg/h9QufLfoHDiGUJznV8agr2zNnv3a20b2JIWpc2EndGr/q+Z68V/sj7Xpl5e3K9wfFzQtv/DQh6JHhphWPyD8kHFWL0HWR9BZqmK1Zx2tVSOZqtLH7VQShJHeAMM+oI/H75i6L2RnOxCgkHZKquXcLjosc4bCeZPk9s9zUwwAcIZ8DoSqYsyngF22QVF4/St91OpWJuPUzN5UodnFaiTy+Ipr867w6jEKi1KV29XDpq1ELerELtBQMqw4qOLwFWFmnqpBKHhIgVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgaEZBLBNOodMc/jljAc9E3PJ3hz2NrvU9CexjmAURU=;
 b=GJ5t7dr7aSawajCmaZrt5Zm8vwQOhPJxbx1BLjWKZus6PnsSqxenkIFIieLfgqeCQGFqq4GtQSW6Hrx9oX5OabgLwKiuYaNImw3RSOYiqcB3N/juR1jU/1pnQKJzVkyxkpf0GesZZAzUadvp9gFi1JAGc8iDV4RIdsEVPikUQeIqfoTr+K4sFJfpyvIns721ZscrOcxw2ogyDcULXmEfYYFH9rOZdtogqAkATUQiR3PdgkxhF3NA4CbEklMRDpQaBAqAxuUPi6PjGFEw/GMmltT9NH0mH2oA/ECB/pNIt5TdUGVVRR7i1F04cbkcaOjZ/tkw8whsVznujKk1G3hCaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7512::16) by CS1PR8401MB0855.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7511::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Mon, 12 Apr
 2021 16:07:14 +0000
Received: from CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f10c:ded5:f64e:5074]) by CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f10c:ded5:f64e:5074%7]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 16:07:14 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Edward Srouji <edwards@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: I need help with the rdmacm tests
Thread-Topic: I need help with the rdmacm tests
Thread-Index: AQHXLZKy9+L0lCpT40evo6v5opdGl6qwzOkAgABDpeA=
Date:   Mon, 12 Apr 2021 16:07:14 +0000
Message-ID: <CS1PR8401MB10960D9933AD29EECE9BBE7ABC709@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
References: <bc01d5dc-4d2c-81ca-0fb3-337d6a160b94@gmail.com>
 <20210412120446.GE7405@nvidia.com>
In-Reply-To: <20210412120446.GE7405@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [165.225.216.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f6f308a-72ff-46d3-1373-08d8fdcd09a4
x-ms-traffictypediagnostic: CS1PR8401MB0855:
x-microsoft-antispam-prvs: <CS1PR8401MB0855E8B2C4E0F1CD02062BFBBC709@CS1PR8401MB0855.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gm3zJ+GMyjeaH6+lV4y3/q+3NqbQRVP+zHE33TthVII9IrT/dg9+2+Pc/f3rr3ugxOf6i8Zhm7A9t8Mf/Kk7oEkEZUCDlY7VrV+TPnNW88LoxMkOgoRQCt6+cYGLy5WZAVhsr+Kx4Z1PPf1mmVVBF9ao2Qku7EDsGRrX/pHHXaf0LfhCCgxfURJQJoX1IynWeuQSmmNOYe8DmRIBw+CEuduUV3RIhTBipQrWzAsN5ccbkTFZ1WgrLsWwcM/pZYs+R9ZNVvy94eTyTHoM6LutpvaZB6QOABcworpK1CdqC5DTo+cfzAhISq+Hd2jm4VNdQ14qnqGqBnfOfR/JKsZIIqMCO517CJJro6cGHh4oMTgETsRBa1+en7WwdrpkS0CMXfYot3nn2BXpJ04YgR6HnSuaayimBoCWjj+HuEFIEa/qY7W2bbJxRzj9kaVXvjKa62QpOcJmd+z4FMGShl6gFy6xywIzWIBo9GIAtAIQZH7b1GmihVVrANZ/PoM7yzvRmrRloYt5O0DZiNC8vrv5nsuvBRah5oNfzROITKtZZNRONGHkxJ0ADpyxkdKJNDrR+M6bDmodxQ+ghVsBdifbEubrk1YQ2NOlBCzB0rR2I2s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(396003)(376002)(136003)(64756008)(66556008)(66476007)(316002)(33656002)(186003)(110136005)(76116006)(8936002)(66946007)(26005)(8676002)(9686003)(38100700002)(71200400001)(54906003)(83380400001)(86362001)(4326008)(7696005)(5660300002)(53546011)(478600001)(2906002)(55016002)(52536014)(6506007)(66446008)(55236004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3wnIY/EwsNZoU83U0xOwmWUSljxm1mvTkhbqVXdDMGSOAgkSABaugfviRFz8?=
 =?us-ascii?Q?RpXw18Z0otf7m1lsKVW+MpIvu53c8ESw7F6o7jKypDwQ34LLaOCOs0mzZtRP?=
 =?us-ascii?Q?HuXBHi+EnGCbA5kPPlJXG3MW3kYwr4HvosuYnAZ833rqSapZh2pC0ZS1UAJJ?=
 =?us-ascii?Q?OOnlww2y7tt9mNI0nueEVvo6+b32NqzxVHObIxpJRbo7qA0XPyU3YCpRTD08?=
 =?us-ascii?Q?sweaCqaQOzukjfjlyz6qxzApMru6Kd34Mp31C5HJZH7RHjXS2yA6Yxn3eBVZ?=
 =?us-ascii?Q?poZxbHf3LHsANwW5nURYGjtFp+2CC3M3mX8r26fOkXrsi1+Xwy5+7OpyIHPi?=
 =?us-ascii?Q?oJbcB73TkYY6SLKrXGCi6X5yu0/4RFCQoOZkMnBFCIkrN+WntCNnTxK/TQ0K?=
 =?us-ascii?Q?ruxhVYRfFLfJCzJI1BzEwX0knYxR+23iEp038LISkPHKVLAqCzObHDIR4qy/?=
 =?us-ascii?Q?Tvc2M5bRYTXhzT3C3TvDLyg+KGxsZXbaO2GZYZZlpoqi6juD+fla3+7skuEa?=
 =?us-ascii?Q?TPB0eumSxCLAfPbHe1zZn6kfEuXCwHdlxlANe4i46PGcwf/jX2wOK9B1xkvn?=
 =?us-ascii?Q?O0iLRAPStsaBLRLNYrMpUBtOQQnJWmD8J2TnUBEqU9mgfxIudUjBdFvKYYaD?=
 =?us-ascii?Q?avm+9NS1ymv44l82dfqc6weBlEDzIgJ67TGxOb9hOxLIjN1QwOPcDlPfpH/1?=
 =?us-ascii?Q?ZQ/fAWCbiCbppwgk1mxXZ0QQhzFCASSULL44hy8x6hpWrPTFNVcxU0cCLhqW?=
 =?us-ascii?Q?/QzIH3bkrEWFPZXhmKGnIF7M+XR1UjGl0op4xSK7kr9u9Ft4ZDOsOgmOgGk+?=
 =?us-ascii?Q?DQvRfQW8KS5r8Hr0gUqichqb5+/poZtyxDMkaXW+r7j7S07MzfCoPEhp8yuO?=
 =?us-ascii?Q?d29fxzCptpwichM9g6IH0DrNcs+9JWRKtEH5h+6NIT5s6aK7o2YXyGrruFTR?=
 =?us-ascii?Q?4jnFUQFqK/ZHsVPewzX+RQ71sD1hUsGhmSpMaTNKlykYdRJa9QlCCKgTzNQk?=
 =?us-ascii?Q?pSOnZarfIE3/fnV8Snxuy+zO2y+hn2B5rj2qQ5XiAV4HwLHzIIy1DS1pyuL4?=
 =?us-ascii?Q?/yzMtrDcIlmaM3kfUDTjNDu6yZBrzF7JkF/WlvlNWRkm0916vjNHIz59Q2aA?=
 =?us-ascii?Q?osa11a/jIFg7/nocJMMfeblpg4OTtawhhTvgChCwEPcnn4XXosdF9Nh+DUcY?=
 =?us-ascii?Q?eeXfLsihjKDkV0p++HfbrkK1kuR2pakhBBqI9Grb+TttdIP7Vz/8wBGUqrJk?=
 =?us-ascii?Q?UgzxCDnwejsNylWmYqKj4tFkxQyTGPK0DxAmPNtnB3wJHxrowRvES6pVGz/I?=
 =?us-ascii?Q?ghXvPrsxsm3Fc/sTDou8XrL8?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6f308a-72ff-46d3-1373-08d8fdcd09a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 16:07:14.3566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YHW0bfz7cdv1zrUlg1iETt71fOyhDiuibpoLW6iJwIRckwiiOQDQpRXOztqgWUWgKarH9O8mQIR6QvfDKnD3Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0855
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: zMUigbAD-t8R1ba78SHJM4IdpzoQ8O1-
X-Proofpoint-GUID: zMUigbAD-t8R1ba78SHJM4IdpzoQ8O1-
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_11:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 mlxlogscore=872 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120102
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks.

-----Original Message-----
From: Jason Gunthorpe <jgg@nvidia.com>=20
Sent: Monday, April 12, 2021 7:05 AM
To: Bob Pearson <rpearsonhpe@gmail.com>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>; Edward Srouji <edwards@nvidia.com>; =
linux-rdma@vger.kernel.org
Subject: Re: I need help with the rdmacm tests

On Fri, Apr 09, 2021 at 05:50:01PM -0500, Bob Pearson wrote:
> The tests in tests/test_rdmacm.py for rxe are failing because they are=20
> not able to compute an IP address for the rxe ports.
>=20
> The python code depends on having the directory=20
> /sys/class/infiniband/<IB_DEVICE>/device/net present. But rxe does not=20
> have this directory.

Oh this is a mistake the tests need to the use APIs to get this information=
 not muck about in sysfs.

> I can figure out how to add another way for the python code to find=20
> the netdev for rxe.

Yes. netlink and the gid table reports the netdev for all rdma devices, tha=
t is what the tests should be using.

Call ibv_query_gid_table(), put every ndev_ifindex in a set, then that set =
is the list of every netdev index affiliated with the rdma device.

if_indextoname() will convert to a string name

Jason
