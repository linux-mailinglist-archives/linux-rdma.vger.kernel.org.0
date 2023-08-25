Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBD8788498
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Aug 2023 12:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbjHYKRu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Aug 2023 06:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244430AbjHYKRj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Aug 2023 06:17:39 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FBD211F;
        Fri, 25 Aug 2023 03:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692958631; x=1724494631;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IJbP6nsd9RKDkrHQ1d7DQefrLSbuJBz2IQS75yczkg0=;
  b=cFfjSy3u+S+h3BD7yUybS22sOnRl2ji7/Gg5cQVB2sES6q+0yEdEXlUP
   CHWA6/dczI98Z2fBovEPh0iOulpVMD9IeGlLhJGbJnr9X6PWjwigG1NKg
   tF7ONbRSu2uzn6RB8Yv+3RNnAMEbohJHshx3ns2a7SDx46A30h6bagS9M
   vDUYIzT1iGwc4FGdOKUTMHXEStMAqjgTL3n/tzdlf842YsdEE8LY9THCc
   I6jjDs9B8orUqlukg4/Odh0l7evbvdq7yVQ82hU5ju+cF1CKiSpQJIYJO
   /bdnsdMmXhTBpX15LskdnAHXwGCgCiPg6XpjEtdoiQUkom+umw8jHx3JA
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,195,1688400000"; 
   d="scan'208";a="354091039"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2023 18:16:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRXJi/yMedyPsydAvLq2EkGSnBuqp/VA+qdeoa36BgV7u4bLh+Re3tdagSjJ+YwtiBnYt39MlOMszP47j998v5plfLW3FeU2L2EKZnGu42uVufTtbEmr2zPZ9H1VM6RWucXAPxBIDIdEXGT9eRRdCmxlGUNmWnBc2ZEi16FyRANKYZQ24haMsvmSYaCL+TvOBFyP6flY9mg0n0Luydry+/LUcyPefoRDSyp7dwEEsjhPhLt1Fk2o7INSO+zxNqDhT6ZP2r++V4v3tPKhu7XYIQw2rv5d4JYnX7SDjEvA38OmrIkreNt+F2mcrv40Ix1ku762KYRMytjSQz4DGMkckQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJbP6nsd9RKDkrHQ1d7DQefrLSbuJBz2IQS75yczkg0=;
 b=mwjlpj+RfjaqUKtQvSbVppoN3PcBn5mUhL2Z3Yx6NdRzYRp+GQO9Ummekzcf159+6P/udPS9OeGE/vCqSVLkly40WdiaJFHiQr6O9Wxo3CN46FrWCXDNsrd3rhvy32So5oXsWa+rgbiGopnRuAFDF+CVVoWQkwL0H3pCCMHA+nYjNatXFeRARborrn6DstEdPuw/6NRXrCznjnEQEKQB0XBc07Z0NaA31eNyzFRBbxEBjrJVVxulGbOOsek4q18OhEkCjLgWPs3b27z31o9q9FrI7bEnjw71GTe5UX/GGAS/1Jpck5bOLyvzkgw2dROwrFl+kqblMLCXRBqU02sYZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJbP6nsd9RKDkrHQ1d7DQefrLSbuJBz2IQS75yczkg0=;
 b=LhCThlu0mP4kZkN10kClBVM5gIs6YhppSRydaeLrvRNOiDpnnhy7lM0ljFURhwSdu6ePlYWez9vpxkKe/4UoS1omgoBPAt5H697qsOC3bPOXu/dSjsR+0h20XbCHgd3EnjSF2lmsRZypwFblrK6gaqLu8ZiwhEcwdgownrLMLQo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MW6PR04MB8916.namprd04.prod.outlook.com (2603:10b6:303:246::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.17; Fri, 25 Aug
 2023 10:16:11 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6723.020; Fri, 25 Aug 2023
 10:16:10 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     Bart Van Assche <bvanassche@acm.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [bug report] blktests srp/002 hang
Thread-Topic: [bug report] blktests srp/002 hang
Thread-Index: AQHZ0/swwnzlQmtfZ0imcm9Pm4sUp6/1jPEAgACO/oCAAFRogIADyeOAgAAG3gCAAJEsgA==
Date:   Fri, 25 Aug 2023 10:16:09 +0000
Message-ID: <rwfnilybc7dek6f2ig5zdu4t7k23dxsuzxjwdeqof5uxpkjgpy@b3wigfoz5yvi>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <0c5c732c-283c-b29a-0ac2-c32211fc7e17@gmail.com>
 <yewvcfcketee5qduraajra2g37t2mpxdlmj7aqny3umf7mkavk@wsm5forumsou>
 <8be8f611-e413-9584-7c2e-2c1abf4147be@acm.org>
 <plrbpd5gg32uaferhjj6ibkt4wqybu3v3y32f4rlhvsruc7cu4@2pgrj2542da2>
 <783a432a-1875-d508-741d-ccc1277bb67a@gmail.com>
In-Reply-To: <783a432a-1875-d508-741d-ccc1277bb67a@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MW6PR04MB8916:EE_
x-ms-office365-filtering-correlation-id: f08162ac-b9e3-4fcb-07e4-08dba5544d99
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kSvkfstoOr1YTJpXeWaLwa5OI4bkhN5m3Y3Lfc0hBH7n2FVD/HX6SzggjrOys93VqW6YPJvOzWyQp65FoWBz9d93omglU1YClDWKqpTSTfHo4h3m/DJU7tha27VKUn0B6I5n5IY1L70vemy+SYEi54iBwf6Wfc4Sfhh7iGR2LF+kGvRwslbOxhWZpEpGRq9kb6um6WhVMefF4E68gZRw3sKn9N0icB0YaKQsw4vxRvuYsUt0dU0JjWDWguksKDNj22MDmIVjAo3zpIjv6k192hf4TD7MDxd5uVOPX1WOGQuYwDrQnflwLio/92SoQrm9zYzp7Gi4xAeqFLVWH0yn4gzlKRou0dJbhUeSPrf9h0Sl4fFQpCsZTPeDAveIMS+cykVjmPibOOhcKgo2ZIG60XzD5QU92QKO0vwAyjOyjSJPRb1R8TdAk5lbGP6S70Y1LktwIMsBN/ANJyMT4JsiwiHzNxBshtjxrCwjGxh1s2lp59p+SWBe9lZ9bEtxhm1VIOx/zf0MRAh3/9xceWPfUj2sdK6+3RnBzmPtJaQql8I0RTZpyrDcDbJmAyW/q+AdgUe8kyw/IQZhSP+cKt817x2Go4GIxS9PmfdgRnxtDkZhW3wi25+jxn7itPD1sv8Z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(39860400002)(346002)(136003)(366004)(1800799009)(186009)(451199024)(5660300002)(4326008)(8676002)(8936002)(83380400001)(44832011)(26005)(71200400001)(38100700002)(38070700005)(82960400001)(122000001)(66476007)(66556008)(76116006)(54906003)(33716001)(64756008)(66446008)(66946007)(6916009)(316002)(91956017)(478600001)(9686003)(53546011)(41300700001)(6512007)(2906002)(6506007)(86362001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xyDcepqoMv2dM3LlwOaVSugAStwu4E+L/0UBXLoAI44it1/GpNIKN7GnhJFS?=
 =?us-ascii?Q?sg/58N1YN6wDnkcZjWKFe/UZdgcEL9bJemrVRtJaBqlgL0bN1RYuDxy0oVwQ?=
 =?us-ascii?Q?Dztze1V7c25ma2pwrXB/gBk9V+p7yIfzBAqUxmpLP3vCYqQCRnq5Fhe4Iyf9?=
 =?us-ascii?Q?LAPobQh9mMmni7CzV7Ee6JZc1JoIrGfsJCJ+P/z34GsH6CeTNkd4rDkVjYW+?=
 =?us-ascii?Q?xX5T7Cz0ggcgUqKI4K54VWiQJcEh1gCYa6xz5dpUyp/L5GvCX1zVCoV56MpK?=
 =?us-ascii?Q?FRKkxof/E7BB7MRTf4Ut7NGDS2Q0uP+sqAWgqr6g93osStdkQk+dHCXi/9Ac?=
 =?us-ascii?Q?hTukinr/XbbT2iAEErv2Zt6Kr8k1J4urMNXqiLOJPRLkrXbJduxOaSthishq?=
 =?us-ascii?Q?W83Eulzmbm+bj6oTlNUXY2uNW13dNCiUQMBv6ja0onUFbOcBd3JnuOa3EE+r?=
 =?us-ascii?Q?cVbYAI9AEFBiMfGQINV0GpUAB1NWmPHTPRB2C/SfbLE4yqFrWoz9AVE9Cdzp?=
 =?us-ascii?Q?ju+KkPInXj1T+JJDB4ASIMQHGd4CX5EfptiYHYgLIXX/PtWVQG3gQaNMCnsb?=
 =?us-ascii?Q?0cisJlS9EdvG6b37u9PSUgy36fFQLKMQK1XvX8xJrips/o+ubygowjY5JG+g?=
 =?us-ascii?Q?oNUoHSZ5eiA+QWUKK8gy3Wi+7uynZ/QFwH+VqkD9GgVeasiSJBFie3srMGKv?=
 =?us-ascii?Q?mMJbo6LJlM2oTTPMDBWxyGVGaOP6QzhliDVpjzOyZt4pl9/R6HuP65TtNFrE?=
 =?us-ascii?Q?Kh1t9y08mTmdDJvLFpBkWD/IJ5e0Cx66czvFCRsw9FiHntLRjXGJotzm5Nmc?=
 =?us-ascii?Q?TFgab/qipOWTAxhk/ChK/Mjh/3MoKPeZgDFbFkZyleu9G3nFZqc+O2IXfU8+?=
 =?us-ascii?Q?4mNzpGvfnjxpcjiDLJX4zpv4ZRM3oAP4yukR0sRpvvIEetVI9LYmZCd+YXqV?=
 =?us-ascii?Q?4JDEfiNVCMfcrbZwjnKpmA1ooetA5uh2aIA2uJv5DEFHEsJfICN2j2TmbVpd?=
 =?us-ascii?Q?M1A/OYNdUkzPCQFVD3f0Ovssc3BpW3/GLoeHMvr0k7RtgeDvCvBUr/b1bw67?=
 =?us-ascii?Q?qPzl7m2S1ekYWdLy+RNZ/sC/VXmrHiZmYNkmrpqemSe4+mrBEezIh6Ww9sPT?=
 =?us-ascii?Q?eu2O1FWV9rU2rIz0z07nmup78+0EkZ6hAKUjF94UwxjNT256TEVrxXK50cu7?=
 =?us-ascii?Q?12gpzWufEPzvV74/z3KMC/mwjSJZwt4yNPYiThexLNx9jntqWFlEacHKkx4g?=
 =?us-ascii?Q?Jy7AEO5wyPYJTesZPhzRfZmQRDdizzId62pS+KFzkmRWrDE1IjfzfMGJ9BwE?=
 =?us-ascii?Q?VlbxdHOkWJgfVvCZgEKR8YZRrsPZiBfz7Te7kS50vwKAmO8/cuYGh3blUuAu?=
 =?us-ascii?Q?d6QrYWwN2l1+U0Dql/YLimxuF/kLf3AN7VP6lrFS3GLW6eIWjMurz+ixyqs1?=
 =?us-ascii?Q?949RSZGL60ZF4u/zStQAs+rNzbysoi6vt7B7bvC+B83OjOnZeT5pacUnSiUP?=
 =?us-ascii?Q?cuYotV8pfKoDby0dvdCcMbrOzPBelKdjNb8Z1whWWWr4h1dtIpxE62a1oH/o?=
 =?us-ascii?Q?IgYqtndqNRbE2SXrBdgf/lbuhv0Wy8GLpppBo0cIWnJRl2IwvpDtvDyiYOnf?=
 =?us-ascii?Q?RGy9okEr8iSCzMWDnaYnRIg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7E347042AB5CAC428DD9ECFA2E292D1B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gh3vPOu8oZj0ErJ1jJPokMYwpuYmDHEcE0MMrpePMX4Ed1Ns5pJfqLtsSgRm7JUB4OBBjt6Jj9uAa92n7mnJsloEcl/+212iz+xkKxa+rP5IJrGeNhHdwi/FAB9AYQVNmMjEtE/rdVVkqll9z/l2w6NxtiA40rNdkzkJYzCaISNUe1ZqIYNanvrDHfdGDKJ42o/fzNRGwnWcEO26PXGXjOetEccM2GpacLnpbEpYM+hb+GjYkgNv+c31bEvxQ2LJsB3eX3qhegWar4hcZ2QebTeuOCAXDV42+cscqm+LnvjKsqe9lOXxEjWz6ivwn0BhoGEYk4iylP44LlAJi+ENTKUk8RZ+JX21xQg7mNMS5Gk7nQ9KUBo+Iv/9TFaAAOdsv68o5vzDAAmfEIRYm9ujJJFqTHgQyBB6R0DHIEJMUc+dXyr9XZF3wb8aI1335oG9Ag18vogr0YwBGLU9AmzxBQsRZ9bKRMZF/uYmOcI9srAp8DlKERX6Dldq2FbVWRD3F/9QA/+SVfi29aLnxYSTnbMv6ECPtUSMTutGqy+BsKtg6d+2pvZh6pIlYss6tbXLSfpMn3Gf6Fn8fC8nJ3OVjVhOH90Ky5Mya6ANC0eXwkDItuZG7cnTsUXITXk2WRnQ+5Zzz94YsWZfOXsSSw7fD1LirBDw3/Im/oHg+bQa3SYCMNuQ9YvIspDsznDcjhWZYrLRsFg40uS2iJawOoEWFCQ8Gq4T+1cMny9P26LUMkpd9xFMEEm6/MvA3CVV729eSGdiWo2x80tVV1uDvEDeyRaSoXj3DZll8yYM/z70g4wbYDZR5ORqMRocC2zY+D3t1epXVJmFE7gFPBgTPQFcwg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f08162ac-b9e3-4fcb-07e4-08dba5544d99
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 10:16:10.0525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZ0YRMFGtTZ07omsBQeZrjS+h5XWP3ud38XAH4uXq3ozj7VxETmUWZogpjl2CcX3upU+tLKoOCQ6VLcRY1U7K/Ymi//aY/0uwUrCPpY2BdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB8916
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Aug 24, 2023 / 20:36, Bob Pearson wrote:
> On 8/24/23 20:11, Shinichiro Kawasaki wrote:
> > On Aug 22, 2023 / 08:20, Bart Van Assche wrote:
> >> On 8/22/23 03:18, Shinichiro Kawasaki wrote:
> >>> CC+: Bart,
> >>>
> >>> On Aug 21, 2023 / 20:46, Bob Pearson wrote:
> >>> [...]
> >>>> Shinichiro,
> >>>
> >>> Hello Bob, thanks for the response.
> >>>
> >>>>
> >>>> I have been aware for a long time that there is a problem with blkte=
sts/srp. I see hangs in
> >>>> 002 and 011 fairly often.
> >>>
> >>> I repeated the test case srp/011, and observed it hangs. This hang at=
 srp/011
> >>> also can be recreated in stable manner. I reverted the commit 9b4b7c1=
f9f54
> >>> then observed the srp/011 hang disappeared. So, I guess these two han=
gs have
> >>> same root cause.
> >>>
> >>>> I have not been able to figure out the root cause but suspect that
> >>>> there is a timing issue in the srp drivers which cannot handle the s=
lowness of the software
> >>>> RoCE implemtation. If you can give me any clues about what you are s=
eeing I am happy to help
> >>>> try to figure this out.
> >>>
> >>> Thanks for sharing your thoughts. I myself do not have srp driver kno=
wledge, and
> >>> not sure what clue I should provide. If you have any idea of the acti=
on I can
> >>> take, please let me know.
> >>
> >> Hi Shinichiro and Bob,
> >>
> >> When I initially developed the SRP tests these were working reliably i=
n
> >> combination with the rdma_rxe driver. Since 2017 I frequently see issu=
es when
> >> running the SRP tests on top of the rdma_rxe driver, issues that I do =
not see
> >> if I run the SRP tests on top of the soft-iWARP driver (siw). How abou=
t
> >> changing the default for the SRP tests from rdma_rxe to siw and to let=
 the
> >> RDMA community resolve the rdma_rxe issues?
> >=20
> > If it takes time to resolve the issues, it sounds a good idea to make s=
iw driver
> > default, since it will make the hangs less painful for blktests users. =
Another
> > idea to reduce the pain is to improve srp/002 and srp/011 to detect the=
 hangs
> > and report them as failures.
> >=20
> > Having said that, some discussion started on this thread for resolution
> > (thanks!) I would wait for a while and see how long it will take for so=
lution,
> > and if the actions on blktests side are valuable or not.
>=20
> Did you see Bart's comment about srp not working with older versions of m=
ultipathd?
> He is currently not seeing any hangs at all.

Yes, I saw it. My test system is Fedora 38 with device-mapper-multipathd pa=
ckage
version 0.9.4. I compiled and installed the latest multipath-tools but stil=
l see
the hangs. Not sure why it is observed on my test system and not observed o=
n
Bart's system.
