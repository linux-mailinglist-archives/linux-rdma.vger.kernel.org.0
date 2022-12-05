Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228C36422A4
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Dec 2022 06:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiLEFV1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Dec 2022 00:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiLEFU6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Dec 2022 00:20:58 -0500
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB38D15701
        for <linux-rdma@vger.kernel.org>; Sun,  4 Dec 2022 21:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1670217635; x=1701753635;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o3mQF83WIz3MY+AJx0Rm4TzcbnYydmWeOkxzrMsRvTc=;
  b=dvgEMmrFu9MJ/9+BBf6vF9SBz02CcBEFNlOcNm+VSgPpmAro134S5I/N
   mRAagUow8E9e0RevhLI4vjAzPhjAeKLvQldnRCTdlXPZpwZf66uOnm5lG
   xNWDtwLcGsCUcp1ftEXQO073BT38XKQqMbL+dAnPvAABclk3r3W8aTa35
   pXaCwlDVHg0IdTAQh35hvx/YFFdB3De8C+oAwrXfcIS8S8yLJcp4Dx4U0
   EzrKA9cPO+sOTbar3K0imufbK2UHOpG5BatbTR+OGOLhL1RJoKqiX6lv6
   L6jm4gg0d4hIVNns1gwmCVrqL33Scbv1YD2lrAz1OhIc1yTDISkymf3Ip
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="79438294"
X-IronPort-AV: E=Sophos;i="5.96,218,1665414000"; 
   d="scan'208";a="79438294"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 14:20:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NglTGBYfFjIBAJSkGOkHtq8m2UsewN0nJK6djin7KIyrHu2Nhy0uAHdZ0zuud+/+Kad1k9fD9WNRCOL530gx6sRxdUqgpt+ILdu86fs4cRZnLxmtNbh25tDPZgMJMtFGKzVTuxCXVejmCnO+Xuz2JT+lf0f8ClJeXhR4wuBVEFmxXIFQjcIGqMkX0Cn3QuLuCe95PuiCI9b47SjPLkYDDTWQOErAitG9updl7gsF16Dolq/4aUf8mvv6c3O4TB6ttyKf+WN66ufehjr7cr4wB9SuBFE36HSeHV0DBvuRS/zGYu0muj7pKSgJbphp3gl9uhwBc6av2O3NZgfrbcWUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3mQF83WIz3MY+AJx0Rm4TzcbnYydmWeOkxzrMsRvTc=;
 b=RMHBcKFqVHp0klCeMDgtUu0y2saInPc2d+Ie6vkOCqx6fsgtqEULXTd4BgAogvH6fUyuft4jTV2tcDeg7kPyFl1q8U3Jnne0HGfq4kJ36Q1MTDSEDMwzNbSGpY7JRxJATt2rZs5e46h/rMf/6hDa0XMBYzvntjv0h5bxkfftBuXFEr9W9mbn1MmT5p/dPvMqHjJ9ZgPvp66ippzjMG5qfFHmcGs9ScYb0+VE6OapTaqyBl926Kd/s6y+0aMTQfhqHY1GuZeRKx0EWoMa5ERLBbWhrgvyFhUar1y/O2GrJWst8IMNpmP3zIyrhqSn69AkoGJ+Hq98mqYjB6ZrXotyBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by OS3PR01MB5606.jpnprd01.prod.outlook.com (2603:1096:604:c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 05:19:58 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::9c4e:a570:cf39:f63]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::9c4e:a570:cf39:f63%2]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 05:19:58 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Jason Gunthorpe' <jgg@nvidia.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
CC:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: RE: [PATCH] Revert "RDMA/rxe: Remove unnecessary mr testing"
Thread-Topic: [PATCH] Revert "RDMA/rxe: Remove unnecessary mr testing"
Thread-Index: AQHZBj2Sj1D5ymiA606IrAf+LL5o7a5aesIAgAAvR4CAAAJTAIAEFQCA
Date:   Mon, 5 Dec 2022 05:19:58 +0000
Message-ID: <TYCPR01MB84558FB69F5703817188FCB9E5189@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20221202110157.3221952-1-matsuda-daisuke@fujitsu.com>
 <CAD=hENcdfWQd5ZiN0_sc-Jy5tCj2SzdBpyGNYuTwsWBTqq9Xjg@mail.gmail.com>
 <a1df668e-eba3-6b48-4ec4-d4aefee19db1@fujitsu.com>
 <Y4oPCJKPdB2wSDxi@nvidia.com>
In-Reply-To: <Y4oPCJKPdB2wSDxi@nvidia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: b768fcfeb88140838fedd1fbc5416b1a
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMTItMDVUMDU6MTk6?=
 =?utf-8?B?NTVaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD0yMjE4YTI5NS04ZWQ3LTQ1Zjgt?=
 =?utf-8?B?YjZkYS04ZDAwMzI1NTRiMWI7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|OS3PR01MB5606:EE_
x-ms-office365-filtering-correlation-id: 1a4d7459-3d8c-4686-72a8-08dad6805a3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ouyyEvl49U4D8QipouK4B6Z+FeF8uo3R2VNAUtL4hdyQU4jrJNHAcSlvnqMo36V6Dsa01s3lBPkwTyym7QdeON/9ABqU29K2E44fibwdmElR7bi6wG8uUvQUkZxfipsfR0JLhTuIzuV+IkVfebMfeN68q0WzTcwKBBFk018yERYpvAuz4W6ohgJNwN5AEpXBDG7PpBMjXvoE64iQKqMCilvJqDBagmaZxMcglFb8kb/9GyZAusU7Ny6vZZQBPkzgYQtGC/qFgGDJTvXO85MUxkl2k7fhD02X3J7DiyTw75X52zvkpLzrKQWsIRveWwKZI8/J7FVNh9rCo3vA9bQq+cFEgXj+d/z5vfLsAwBaMxkCpz0LjdDhT4nmoKPyo63FL2ABfNxr0zl2W+22OvwCxc76hj5stk7jgR4kDKQm9DT2zUAE8BehUkmAXnPDCue8/yk1Uq6pR3Cg8+eZ1pAkf6CAbYo16jEmPrTRYtFS8MLtBq6Ynxp1se2/U1nvHveIw6ial8cg7nhTVGsYYgwbKYvDqxQfCztqvQtBZojqO7mxwXWzooTQVSBvENxGh6+VFgk8oeOvB2zduvSQz8rFqOYQXR2GbbVKmYu4V4JMCSRPgOSCuBvxa3HRncpIkjIg7dRkfNKYNakDLXLY0MeclbU6PQtWTny95p63HUQF9TNDi9WyKiz7DAcc+3yCx3IizLEzb7Lk6UirqTsbZK04KpTUR11rrP/MHIMV9l8WR2lOSBG8HzbZRbPW2AefCqLDBMpRSMQ9qMCY/Ky23ml1loYQjRy8YFFJlW8E6xXQQjY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199015)(1590799012)(2906002)(110136005)(966005)(4326008)(478600001)(33656002)(316002)(53546011)(38070700005)(6506007)(7696005)(6636002)(54906003)(85182001)(86362001)(55016003)(8676002)(64756008)(66446008)(66556008)(66476007)(71200400001)(76116006)(66946007)(83380400001)(26005)(186003)(9686003)(38100700002)(82960400001)(5660300002)(122000001)(41300700001)(8936002)(52536014)(1580799009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzQ4NGVmZThFYlc1b3hwdmY1SFBpekJLUEVaZURBOFBQcmRyQk0yaVp0MVBv?=
 =?utf-8?B?Q1VhcUdGaHZDa2FvT1JYWW5sNzljbThRSXhHRGNsYm5OKzAwT2QwZ0Q4UEFr?=
 =?utf-8?B?czBQUWJIeWxEY1JBYTVNM3FzcHNBR0RITTVWUGFHNXFXei9lT1lYUU5Za0U4?=
 =?utf-8?B?ZHlhaUdEQVNmYUZHeWMxSmwzR3Ywclo4UTRMVGZlRlFjQTFVbXh6UjB6YURV?=
 =?utf-8?B?MW5YWi9jbGlyV0EzZllwYTZ4bnFxSUtIU2Q0ZDU1RUI0NUhiSTU0SHpWNVM1?=
 =?utf-8?B?aVQ0VzQ1cnhFdXlYSzZFVVdQOTh0VlEyOFRROGJ6ZzhENUxxUGt4eUZwaTFH?=
 =?utf-8?B?TVNRRGpPRG9iMnUzNzVTRytYUFV2c3ZQTGF1aTVnU2hKSGEvV1VTSmNZakJN?=
 =?utf-8?B?SGY0TU9hTnc4UnI1M0Jpdy83ZmZON2Iyc2JGc2Q3bXhMWGtVL3ZXVjhsNmRM?=
 =?utf-8?B?NzRCODNrZW1zYUd4ZjFoVllXOUU5V1dyZnR0K1BtZC9QZEtacnhUNDZqVXpC?=
 =?utf-8?B?ektLejRwa2pkRm96dXVRRjkrMUFUREgreGZsMHRGWUxaWWtvejJqTXZneUR6?=
 =?utf-8?B?UXdsY0ZwRmZrdTVnU3lBSXhVTGw2NlVqT3ZSaGQ3UE9WRnVva2s3UXB0VSth?=
 =?utf-8?B?VjhmQWpTandFZ1FheCt5VDczMjZpdnB5NHlPdlN1N2lOY2Z3emg0SXRqbHMv?=
 =?utf-8?B?RWF1SjBXZmRDYnMrTUNWZWxBZExwaVdFQ0ZMR3RvOG5iZkZSV1hwTzMrRXdo?=
 =?utf-8?B?aUdnd0h1Y2gzK3lsRGxWbHNuSy9ZS2xZK2hkaUx5SVVwRVpQUXpIS2MwZUI5?=
 =?utf-8?B?ZUIrdmlEU3BJSW4rUG9xdjhtK0NBQWM5d05VWlFkcXc5d29IMkVzakdNcm53?=
 =?utf-8?B?Snk1MXVzS2pSY1hDd21idjh4cFhaU3BxenNVczFFWUFWL0QxcktTR3VOdUtK?=
 =?utf-8?B?S1d6bnZIQzMrUnE0dDZkMVY0SlF1WFhzaFhucjR0bnBtUWRiV3FLNC9YbXc0?=
 =?utf-8?B?eGtBYUFTYXBZMDMrNUlnZ2pyeldpLzlndUl4WHVmaGJYZ1FKZWI5SXM5cldi?=
 =?utf-8?B?d2FWejAvN2JTYlBzL3BhTVdYNWVtQVp1ZkFxb1Z3eHNRYjhBeStzUE1ubUZl?=
 =?utf-8?B?ckNwSldCTnlaSTQwbjBkMzEvc3oydFd6Q2k3Y1hGUkxYRC9jOUJiY2ZaMk90?=
 =?utf-8?B?N1QvYUdFOGhTaW1SZVhEaFNFUTRyaDBTYmowTXhnRVJNTTcvb1dGRit1YTAr?=
 =?utf-8?B?bTd2emZ0Z0VtOHVPOXh5NU9neGNER3JPMTdrbXdEN3BBbTk0OWFaRmN0WlNQ?=
 =?utf-8?B?Nm1QU25ZRDd5QWNFeEZ6OU9OZUE5dG5NKzFuWU1RamRzeUF1RDBhTnFkdFYy?=
 =?utf-8?B?RFQxY2hYYmo2ZU1XOUh0Q0djdWpJV1c2a2hNMHFUUmFUaTM2UUJIYkRxa0hy?=
 =?utf-8?B?bGdSS2xla1h6ZGVCM09EYXJxMzh5cSt5ZG03UkprcWNuRVRxa0Z6b2JFalRW?=
 =?utf-8?B?U2tCejJJdTRWbW5YTFNrbm4xWGVNVUtDdHBWY3FHd2FXRWJxNzIvOFhLVHhW?=
 =?utf-8?B?eXRBdHVMUndaby90ZGR4YjB6Ukp0dXlCODFheitCVmwxVmQ5R1BtYnhETWpm?=
 =?utf-8?B?UmFEZEFDN0pRcFJJYnJxai9GR0R6TFhOWFFGM3pJTGI4b2JhTU55N2pGdmZS?=
 =?utf-8?B?R20ySnVUR2MwdHora3dEZjkyeXdyUXpWNWVBVGVxbGx4ZGZkbkRoVzZzR1Bs?=
 =?utf-8?B?V1BlKy8vLyt3SVc2d1VtWngrSXRMQzBtV0NaVFhoOU50Szl2S3hpanhYdGRS?=
 =?utf-8?B?YzI5Vk8rV25Zc1BnSnAzZjFSSzNxa0pCVVNjTGUxc2MxRXZ2UjkyTHozOFpN?=
 =?utf-8?B?aW0ya2NYQWFLK1FETXNCQU5tNU9xWHdVK1dIaEYwNWxNQVZOZkh5a1NnM0RV?=
 =?utf-8?B?a1ZnNFpvS0p5NW9jUDhtQjlPRy9LN3RZRGxsTzA5T2pyQUlzMnJVU3QwR0Mv?=
 =?utf-8?B?LzZOY1piVU5jYVdTVVFFQ3ZxRXNwRXZ0N0ZJaExMcU1SQnUwWFlXUndKS2NY?=
 =?utf-8?B?ajhLUnBNT2lVSGFxYVlxOU90VTlURWRndnM1MkoyYnRTbkJ2UHdMbFBDWlYw?=
 =?utf-8?B?VEduWWRQczVldkVqVVc4UFd2R1hkL3phQVBtRjRGbS8wZjJZMXJnRVR1a09R?=
 =?utf-8?B?dFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ezoj9ipHW4Y8X3w5O4ES00aOh6+cv3PQyPRD/TvwGd/RTmxEetG0caSCLvfXh3Z053Yt80HHIr3LC4LYtI+bKvPvIGygp7yoe913vCDrQi7nYykrDrYUpj+BdF7/GmioGpxY4j+9wPaaFvwXZ3G1JspnJWg8iXXaMGhhWJ1M7ddUjf3ARtavXBptiUIw0GrZ4kp12wc38EvzpPNh4WItqbZYOGasDOKO8prwv6388ARRLvUMy0mzskgOll/Nss9K+LenRWz/pgNWDILletKMcfyD/N4VUBFxhYZzMFIFtNNr5/2DjE5i7jgkg/FQUvb2ac0ri4I5q1hdwrthqG5A94oI2PHQleg/xwFMuW6MZlYklpzpqy/DRPBvVubD3lsafdIFpwoFDPwv0elzgVQj7zFit3QLzRKz46wlLDJxJWR/rToPs6I2ZdUk7PLar4in8eJp+Uw81038zf5pyFBY4Kb56tzKXZ71QteWeqbECPc3bhpL8FpBsz8suo+EAs2Dd6Jj9C3Sg8RWeP2MmX77dgGWS4+dW7PR5vl1jc+15LA86b85JN3Y4EN/etVTeUQFUcA0Unzf8+1IQdzHaF1xfmg6uQMWhbzvT1ObQAW4joaNKuItnypKmKPzBZAU6YUY9DIEF/WSh0+ZZpox1f0lU4GfrwuuTKmjS9Za1ecUxkjSqyfZjUcAonCOSsmZgAxOcGYiOq9cEGxGsei/QmH8luN71HEJnxyNYDiwCtj5XCV/nz1EfMOb23ft+amJ9wR3JffNrmcIJBS83r5XSKRlvVYav221GsnUXoXgOVqlsgl4oyrugweabwF2mj2IOs4JHCN8MvE9Np8tj8IKqgaVVXnamvGDqIz8/kZsle6eFbxjMZVf9b040bsOUwWINGCF
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4d7459-3d8c-4686-72a8-08dad6805a3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 05:19:58.4102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X6VP8t/9DMKJXxQ//2tX8Y9iLjacUA4HXIsX3i5/QwSz7h3ngYl/Eap1oW1qdaTf/o8U+oYvygufh8NLMkLoLfjscH8seYRqgo5AaDgwGJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5606
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gRnJpLCBEZWMgMiwgMjAyMiAxMTo0MyBQTSBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IE9u
IEZyaSwgRGVjIDAyLCAyMDIyIGF0IDAyOjM1OjAxUE0gKzAwMDAsIGxpemhpamlhbkBmdWppdHN1
LmNvbSB3cm90ZToNCj4gPg0KPiA+DQo+ID4gb24gMTIvMi8yMDIyIDc6NDUgUE0sIFpodSBZYW5q
dW4gd3JvdGU6DQo+ID4gPiBPbiBGcmksIERlYyAyLCAyMDIyIGF0IDc6MDIgUE0gRGFpc3VrZSBN
YXRzdWRhDQo+ID4gPiA8bWF0c3VkYS1kYWlzdWtlQGZ1aml0c3UuY29tPiB3cm90ZToNCj4gPiA+
Pg0KPiA+ID4+IFRoZSBjb21taXQgNjg2ZDM0ODQ3NmVlICgiUkRNQS9yeGU6IFJlbW92ZSB1bm5l
Y2Vzc2FyeSBtciB0ZXN0aW5nIikgY2F1c2VzDQo+ID4gPj4gYSBrZXJuZWwgY3Jhc2guIElmIHJl
c3BvbmRlciBnZXQgYSB6ZXJvLWJ5dGUgUkRNQSBSZWFkIHJlcXVlc3QsIHFwLT5yZXNwLm1yDQo+
ID4gPj4gaXMgbm90IHNldCBpbiBjaGVja19ya2V5KCkuIFRoZSBtciBpcyBOVUxMIGluIHRoaXMg
Y2FzZSwgYW5kIGEgTlVMTCBwb2ludGVyDQo+ID4gPj4gZGVyZWZlcmVuY2Ugb2NjdXJzIGFzIHNo
b3duIGJlbG93Lg0KPiA+ID4+DQo+ID4gPj4gWyAgMTM5LjYwNzU4MF0gQlVHOiBrZXJuZWwgTlVM
TCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDEwDQo+ID4gPj4g
WyAgMTM5LjYwOTE2OV0gI1BGOiBzdXBlcnZpc29yIHdyaXRlIGFjY2VzcyBpbiBrZXJuZWwgbW9k
ZQ0KPiA+ID4+IFsgIDEzOS42MTAzMTRdICNQRjogZXJyb3JfY29kZSgweDAwMDIpIC0gbm90LXBy
ZXNlbnQgcGFnZQ0KPiA+ID4+IFsgIDEzOS42MTE0MzRdIFBHRCAwIFA0RCAwDQo+ID4gPj4gWyAg
MTM5LjYxMjAzMV0gT29wczogMDAwMiBbIzFdIFBSRUVNUFQgU01QIFBUSQ0KPiA+ID4+IFsgIDEz
OS42MTI5NzVdIENQVTogMiBQSUQ6IDM2MjIgQ29tbTogcHl0aG9uMyBLZHVtcDogbG9hZGVkIE5v
dCB0YWludGVkIDYuMS4wLXJjMysgIzM0DQo+ID4gPj4gWyAgMTM5LjYxNDQ2NV0gSGFyZHdhcmUg
bmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgMS4xMy4w
LTF1YnVudHUxLjEgMDQvMDEvMjAxNA0KPiA+ID4+IFsgIDEzOS42MTYxNDJdIFJJUDogMDAxMDpf
X3J4ZV9wdXQrMHhjLzB4NjAgW3JkbWFfcnhlXQ0KPiA+ID4+IFsgIDEzOS42MTcwNjVdIENvZGU6
IGNjIGNjIGNjIDMxIGY2IGU4IDY0IDM2IDFiIGQzIDQxIGI4IDAxIDAwIDAwIDAwIDQ0IDg5IGMw
IGMzIGNjIGNjIGNjIGNjIDQxIDg5IGMwIGViIGMxIDkwIDBmIDFmDQo+IDQ0IDAwIDAwIDQxIDU0
IGI4IGZmIGZmIGZmIGZmIDxmMD4gMGYgYzEgNDcgMTAgODMgZjggMDEgNzQgMTEgNDUgMzEgZTQg
ODUgYzAgN2UgMjAgNDQgODkgZTAgNDEgNWMNCj4gPiA+PiBbICAxMzkuNjIwNDUxXSBSU1A6IDAw
MTg6ZmZmZmIyN2JjMDEyY2U3OCBFRkxBR1M6IDAwMDEwMjQ2DQo+ID4gPj4gWyAgMTM5LjYyMTQx
M10gUkFYOiAwMDAwMDAwMGZmZmZmZmZmIFJCWDogZmZmZjk3OTA4NTdiMDU4MCBSQ1g6IDAwMDAw
MDAwMDAwMDAwMDANCj4gPiA+PiBbICAxMzkuNjIyNzE4XSBSRFg6IGZmZmY5NzkwODBmZTE0NWEg
UlNJOiAwMDAwNTU1NjBlM2UwMDAwIFJESTogMDAwMDAwMDAwMDAwMDAwMA0KPiA+ID4+IFsgIDEz
OS42MjQwMjVdIFJCUDogZmZmZjk3OTA5YzdkZDgwMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDEgUjA5
OiBlN2NlNDNkOTdmN2JlZDBmDQo+ID4gPj4gWyAgMTM5LjYyNTMyOF0gUjEwOiBmZmZmOTc5MDhi
MjljMzAwIFIxMTogMDAwMDAwMDAwMDAwMDAwMCBSMTI6IDAwMDAwMDAwMDAwMDAwMDANCj4gPiA+
PiBbICAxMzkuNjI2NjMyXSBSMTM6IDAwMDAwMDAwMDAwMDAwMDAgUjE0OiBmZmZmOTc5MDhiMjlj
MzAwIFIxNTogMDAwMDAwMDAwMDAwMDAwMA0KPiA+ID4+IFsgIDEzOS42Mjc5NDFdIEZTOiAgMDAw
MDdmMjc2ZjdiZDc0MCgwMDAwKSBHUzpmZmZmOTc5MmI1YzgwMDAwKDAwMDApIGtubEdTOjAwMDAw
MDAwMDAwMDAwMDANCj4gPiA+PiBbICAxMzkuNjI5NDE4XSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6
IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQo+ID4gPj4gWyAgMTM5LjYzMDQ4MF0gQ1IyOiAw
MDAwMDAwMDAwMDAwMDEwIENSMzogMDAwMDAwMDExNDIzMDAwMiBDUjQ6IDAwMDAwMDAwMDAwNjBl
ZTANCj4gPiA+PiBbICAxMzkuNjMxODA1XSBDYWxsIFRyYWNlOg0KPiA+ID4+IFsgIDEzOS42MzIy
ODhdICA8SVJRPg0KPiA+ID4+IFsgIDEzOS42MzI2ODhdICByZWFkX3JlcGx5KzB4ZGEvMHgzMTAg
W3JkbWFfcnhlXQ0KPiA+ID4+IFsgIDEzOS42MzM1MTVdICByeGVfcmVzcG9uZGVyKzB4ODJkLzB4
ZTUwIFtyZG1hX3J4ZV0NCj4gPiA+PiBbICAxMzkuNjM0Mzk4XSAgZG9fdGFzaysweDg0LzB4MTcw
IFtyZG1hX3J4ZV0NCj4gPiA+PiBbICAxMzkuNjM1MTg3XSAgdGFza2xldF9hY3Rpb25fY29tbW9u
LmNvbnN0cHJvcC4wKzB4YTcvMHgxMjANCj4gPiA+PiBbICAxMzkuNjM2MTg5XSAgX19kb19zb2Z0
aXJxKzB4Y2IvMHgyYWMNCj4gPiA+PiBbICAxMzkuNjM2ODc3XSAgZG9fc29mdGlycSsweDYzLzB4
OTANCj4gPiA+PiBbICAxMzkuNjM3NTA1XSAgPC9JUlE+DQo+ID4gPj4NCj4gPiA+PiBMaW5rOiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzE2NjY1ODIzMTUtMi0xLWdpdC1zZW5kLWVtYWls
LWxpemhpamlhbkBmdWppdHN1LmNvbS8NCj4gPiA+PiBTaWduZWQtb2ZmLWJ5OiBEYWlzdWtlIE1h
dHN1ZGEgPG1hdHN1ZGEtZGFpc3VrZUBmdWppdHN1LmNvbT4NCj4gPg0KPiA+IEdvb2QgY2F0Y2gs
IHdhbnQgdG8ga25vdyB3aGF0IHdvcmtsb2FkIHlvdSBhcmUgcnVubmluZy4NCj4gPiBJIGhhdmUg
bmV2ZXIgZ290IGl0IGluIHB5dmVyYnMgdGVzdHMuDQoNCkkgZm91bmQgdGhlIGlzc3VlIHdoZW4g
cnVubmluZyBteSBwZXJzb25hbCB0ZXN0Y2FzZSBmb3IgdGVzdF9vZHAucHkuDQoNCj4gPg0KPiA+
IEFkZCBhIFRPRE9zOiBhZGQgcHl2ZXJicyB0ZXN0IHRvIGNvdmVyIHRoaXMgc2NlbmFyaW8uDQoN
ClpoaWppYW4gdGhhbmtmdWxseSBkaWQgaXQgdHdvIGRheXMgYWdvLCBidXQgd2Ugc2hvdWxkIGFs
c28gaGF2ZSB0aGUgUkRNQSBXcml0ZSBjb3VudGVycGFydC4NCkZ1dHVyZSBjaGFuZ2VzIG1heSB0
cmlnZ2VyIHRoZSBzaW1pbGFyIHByb2JsZW0gaW4gd3JpdGVfZGF0YV9pbigpLCBzbyBJIHBvc3Rl
ZCBpdC4NCmNmLiBodHRwczovL2dpdGh1Yi5jb20vbGludXgtcmRtYS9yZG1hLWNvcmUvcHVsbC8x
MjY5DQoNCkRhaXN1a2UNCg0KPiANCj4gWWVzIHBsZWFzZQ0KPiANCj4gSmFzb24NCg==
