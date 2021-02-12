Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31FD319F68
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Feb 2021 14:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhBLNEO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Feb 2021 08:04:14 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53336 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbhBLNDp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Feb 2021 08:03:45 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CCnqXi167615;
        Fri, 12 Feb 2021 13:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=v+l4+Er+7i7VZNn2G1O9q9vtJNL+A9i0OGVECbn3DCI=;
 b=OUYZlCT7t0uGjARTUsLjdzSse4hqa5o32bCwsWUOVr4EfIAVYkd2EhPx9tvj8kkxomH+
 RMa+N+YH+ygSuT8RWUf42bN4Iri9nkJUFsEFyT/aFlxXH4ykz0i1R3QsTDvKVzvwGhxM
 B6Hv67hG9tycz6KiswifnlAX9slwuCfsoBWghxtAcqvrfqVHlTcKuZGNH86zcaBjg4Q/
 hQoJb9e1nsFrFkzb1018sBFY0nMDqIpSGmOJ++Mbv+3HFDTYk0QyE4oZrCRmlYMtyFEM
 XkY1z+RZqTJCBG4Cl5+SQ0zC0EEcepIg6amERpctxQ7SCL75jA3v/GeItr3y2PMihS02 cA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36hkrnb215-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 13:02:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CCo7RX055581;
        Fri, 12 Feb 2021 13:02:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by aserp3030.oracle.com with ESMTP id 36j4psy9aw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 13:02:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZttTZv9KKw7a16L96ECIN66f/dNRp7oXQJhdvPIey/hwHVzHz1wgy+eilF2k34n06WYI6QHlI4N7X0XXXj7VuNSxpALShpP85/lSUNGhYUTjVs/m5Md3C0pebTUc4W32GuRPLoqHeVHQNxtJ0+R2o8HITtD8fM/78+AiaJfRa5tm2i38MPR2afaqOFoX3ABW+AMsQig3nOwlln/9AzEzlw8M7E2tpLlEeH7eO5qlcpC23b1XFyM63sIxpm+Z+3KMRoQOhOp7mIspR2y5z+EHRhS7Xax1vg85kwNwx5Y+yzcDWnmPB0kPVAld+iXRhdwm8OxjlTacFSXbGVp1E+MQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+l4+Er+7i7VZNn2G1O9q9vtJNL+A9i0OGVECbn3DCI=;
 b=bwhQdfI5zOkIXPFq3SHlvJ1DpIY1qcmgr3xWZIEoSRlKiyQ4IhCOG4rYlxny3qNLFFyVumQxLzvpF+3vKrEyAwpQeqOaJ3z1YSt/FrEuRQJK5C3lnq8XZM0mDSMGfer2CoX+ddWNVLOFSsAgt/x3RKJ64XVFf0+gXGZr1vsB7zQ8lkLYqxf0vYV132R/ggYLOquEDaA3k/yDaufMxe8p3n5wDEMOHUe4zuGa0TrJ0ebWg3H0RFV96Zc2LAmOhSJ4eE2sMZSoSTMOALqH3bOr9rlsRYuenZUibtWor8TvFblaluFaOIGC3toPuGbrSW0iwAoGYDsyAnDv++FfxmEHkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+l4+Er+7i7VZNn2G1O9q9vtJNL+A9i0OGVECbn3DCI=;
 b=jbMSWUPzXKzNS2uSNTwXlQ++s07z8rEm9nE5FDjiarq+tG2CIb9QqfG9kmSmjkhJo8dq8Y6v5nHeJogp4bNkLgrKS0f74jO5KvOKQnqLfYFYHOqaOmgXLgPiExFs3vqV65Phn/+64LRVG+tw1w84W1WP1kjZuzC68+Arvbc0qNs=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4653.namprd10.prod.outlook.com (2603:10b6:a03:2d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.34; Fri, 12 Feb
 2021 13:02:57 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3846.031; Fri, 12 Feb 2021
 13:02:50 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>
CC:     linux-rdma <linux-rdma@vger.kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: Re: directing soft iWARP traffic through a secure tunnel
Thread-Topic: directing soft iWARP traffic through a secure tunnel
Thread-Index: AQHXAK0VnkapTOBOUkmZOH4IwKrYcapUdjKAgAAHLwA=
Date:   Fri, 12 Feb 2021 13:02:50 +0000
Message-ID: <4B1D8641-3971-409C-B730-012EDE4D3AEB@oracle.com>
References: <61EFD7EA-FA16-4AA1-B92F-0B0D4CC697AB@oracle.com>
 <OFE25AAD0A.3B8CE2E0-ON0025867A.0043F201-0025867A.00455111@notes.na.collabserv.com>
In-Reply-To: <OFE25AAD0A.3B8CE2E0-ON0025867A.0043F201-0025867A.00455111@notes.na.collabserv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: zurich.ibm.com; dkim=none (message not signed)
 header.d=none;zurich.ibm.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78235a8f-003a-46b9-e3ba-08d8cf5680e5
x-ms-traffictypediagnostic: SJ0PR10MB4653:
x-microsoft-antispam-prvs: <SJ0PR10MB46537E14F35F1EC1BEBFC601938B9@SJ0PR10MB4653.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EfBJjpnm6pXubMBfvjJtVDnj4qPojU8uB8bP8gqezfkzau9m9ZstLTHhLNpxXEG0ZRQDEFqIkA8XgK7LqLkYqcpUjEB7F0JKtanGf+FHe5XNU6JHU/UreG+IpPLrdm6di4uQSi+nzmtpWp3qILNJfIZkBMwls4V4iq0V2Kj8MRyvMqqwPg1NgMbvNkhbR7me3SLk0IR7EFsSYxyuBLK8Fveu1fqIRBS+KEVjlc4xxmAAhTZ7KKKkc0PgGJVFw3gz/fflDdLApzq9JbJiZYK1TOwsdVmjbbAaioBB97/vzFJETnOKjns1i6F7qk/80R//DlcFjp1fsznreSVZHbfmIOcd8B2NPGmuL0XRlpQkxTuVxH+2owozGfSXaWDOL85bBYlfyCW1OdSeI0zI0MCyMA7iheXQVcnUPQGNTE5jmt5JIe2wFBTvVTdpkkura+oWxOnccFpW5AaPvG6N9RbbExYTZdNPJ/G9zhH759fnGTbAK9lMuW+3cfAY5+5Vl0nneI2I3EWDz2j7cgBs8B/ghh7xYSUdK3F+7/59XIfpatLRmjMN9J1HB95YgrapMRqt86BvWD3GAahOA6mxi7Mg4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(39860400002)(136003)(376002)(2906002)(83380400001)(54906003)(86362001)(316002)(6486002)(4326008)(6512007)(8936002)(478600001)(8676002)(76116006)(71200400001)(91956017)(186003)(66446008)(64756008)(66946007)(33656002)(66476007)(6916009)(53546011)(6506007)(26005)(66556008)(5660300002)(2616005)(44832011)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3IZTCgixR1J96eW1GdGuVuQniHxRaVYJ1iSjlNVcdLbuEbZVOnRG+cyJIMnA?=
 =?us-ascii?Q?Q7vrXDqpmk3frF0BjnXhmcbYSkXOar2p4ll+b1QVkazPlA1rpmp6JZkVwaQB?=
 =?us-ascii?Q?GBSC3KoGaENTQV5eET4XQ2uEocPErse+u8zHQCXDrl3L23yiwBhNG/OOux/X?=
 =?us-ascii?Q?5dOITkfs1glg9c4kmPjz63n73Um5aenohaUFipzXa9etVeNiqsECEAKHPuvA?=
 =?us-ascii?Q?YcdJEphoZpK+Cb863rJp/oM92ZyXcRRtnsvSdDmrdfQCU3qn3dtBVG52L2XC?=
 =?us-ascii?Q?wi1D3uCAJUnEPcdoPhgW6ZlLP64S4WWj0uExLhYuk4J4K+19htUz3YRkIdJT?=
 =?us-ascii?Q?+Oz+kFrGxwhdJ0lM8NEztJsTbw8K0Aj0rIPWAheKIqzkI1Ezvw9hQu1D56F9?=
 =?us-ascii?Q?c/8+hxDgwPuI4Xj+pbh4RGkTrsWjVTNjcHTt47cn1HbodyyQJ8vl9frleWqe?=
 =?us-ascii?Q?YXH0tmtvOe1bkUD47iMOUUuQ1Ajr5PtqP4opETmAaxjFacpBRrxdwD+F8yIA?=
 =?us-ascii?Q?Tn99jol3rN0l6gANlUui/igzcTaMLoy0BAJLOex0UeIDLtSbKoqQcdAeWcRU?=
 =?us-ascii?Q?EkB+QVCAJiQqKv7ZyWPehYLJjRpP9mUFp9XEmIXbohmZaRE/LLCBwg/5Vqf9?=
 =?us-ascii?Q?WMRw1q1NjoUzCxnF3rDkN+st0ai4KHd7RLq6UevCh/iN6gJKoeHyfqEvqAAC?=
 =?us-ascii?Q?HqITrR+qJHCEfEeXnYI0DPf72E7IYT+cQr82szpSphZCLkan/7TLmZjxULSR?=
 =?us-ascii?Q?DLNvv2+d+PfxbW/oGjZ2qgUu4Pa2I6kQoQsCR0w60U9sN93Zba21AJc00iyM?=
 =?us-ascii?Q?gReZJ7b8YhU8D8vTAyCkfekHmnIwuXQL40sSMMwYnTX7vCzETbxsMSdNap+E?=
 =?us-ascii?Q?iN+ka1PAilcn3PktAzDEbplqxxdGF8cqqb3WiJzPDATtkLlWpWBYnCFgBC9c?=
 =?us-ascii?Q?hg4TRGX92SIZOrvttQNPPbFge33kbUPkuvVGYe41fQkA9o6sO1EwCgpok40f?=
 =?us-ascii?Q?GJkLuLrvAupw8g2HBKfcTga9MjWdW6WAh6nrIL/IhfHyGrKmGWaJdaspepQh?=
 =?us-ascii?Q?WTaTKtJh6maczck5trtfvdfLjAwXkDaLYyhF7BHU1HxyUB2fOL/ugCD/q4Ea?=
 =?us-ascii?Q?Fgv8cQncE5qX1LOQjWtTYKX/iL40kD8lSLwQ2Kq6l6RvsbWxp9xtUgJWxqoh?=
 =?us-ascii?Q?4h9rQlOifuzaSb0klkkrXwIX4lS1aZ5/7iP1wDvLgHBG5ctMlkEpWPIPse+2?=
 =?us-ascii?Q?Fek95AQuBD25X4p5aZwTVy87ENX+kPweu9EeYc/9uS0dP0hdp9oV4J5KyHKE?=
 =?us-ascii?Q?Z7Sw00u/00cQeRrXf2ogvQfZ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <791E8A87ACEA6141A28D315021CBFD9B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78235a8f-003a-46b9-e3ba-08d8cf5680e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2021 13:02:50.8586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ch+bztoEIP5ui8TUbflHaBIu0eo+aWVefByvrg6TAzUyUGweAvzQVO+bmYfuVhCpR2qE/9PJGNmdNC8AKBZgKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4653
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120101
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120101
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Feb 12, 2021, at 7:37 AM, Bernard Metzler <bmt@zurich.ibm.com> wrote:
>=20
> -----"Chuck Lever" <chuck.lever@oracle.com> wrote: -----
>=20
>> To: "linux-rdma" <linux-rdma@vger.kernel.org>
>> From: "Chuck Lever" <chuck.lever@oracle.com>
>> Date: 02/11/2021 08:38PM
>> Cc: "Benjamin Coddington" <bcodding@redhat.com>
>> Subject: [EXTERNAL] directing soft iWARP traffic through a secure
>> tunnel
>>=20
>> Hi-
>>=20
>> This might sound crazy, but bear with me.
>>=20
>> The NFS community is starting to hold virtual interoperability
>> testing
>> events to replace our in-person events that are not feasible due to
>> pandemic-related travel restrictions. I'm told other communities have
>> started doing the same.
>>=20
>> The virtual event is being held on a private network that is set up
>> using OpenVPN across a large geographical area. I attach my test
>> systems to the VPN to access test systems run by others at other
>> companies.
>>=20
>> We'd like to continue to include NFS/RDMA testing at these events.
>> This means either RoCEv2 or iWARP, since obviously we can't create
>> an ad hoc wide-area InfiniBand infrastructure.
>>=20
>> Because the VPN is operating over long distances, we've decided to
>> start with iWARP. However, we are stumbling when it comes to
>> directing
>> the siw driver's traffic onto the tun0 device:
>>=20
>> [root@oracle-100 ~]# rdma link add siw0 type siw netdev tun0
>> error: Invalid argument
>> [root@oracle-100 ~]#
>>=20
>> Has anyone else tried to do this, and what was the approach? Or does
>> siw not yet have this capability?
>>=20
>=20
> Hi Chuck
>=20
> right. Attaching siw is currently restricted to some physical
> device types. This now appears a useless limitation, since
> it prevents its usage in the given setup, where it would
> be just useful...
> Relaxing that limitation is a rather simple code change in siw
> - but that would not help you asap?
>=20
> In any case I'd be happy to help with a fix, but participants
> would have to rebuild the siw module...probably no option?

Participants bring code and build infrastructure. A patch now
would be great, and we can provide you with Tested-by: !


--
Chuck Lever



