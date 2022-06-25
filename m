Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D8555A5AB
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jun 2022 02:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiFYAzr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jun 2022 20:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiFYAzq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jun 2022 20:55:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91AE50E32
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jun 2022 17:55:45 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25P09gJg006144;
        Sat, 25 Jun 2022 00:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=grFiVf7aORITHzKKTetxZsI3MI3HYC4PIznIs+ILUNw=;
 b=nN5SFmT45Wpsyu7kB4yKT8tRg/U/e1SJ0kA2zw/Lw+V/zFrecjOYxuFR/eO0up2JgFpU
 61/n/9qlcifCf9o/BIfWb1MUo5Q5yYg2AN//b2v7pOLQsJ56Adus9JyquCVyZH55ygfZ
 m7VW9EnCmSMvqU2QoY+aT8XzBi5OGjIrn1c7UAgr0i/oUzeXLLuVxq1RvTYff9bxl3rL
 PycZ3MKpL/OLNvyOfC/2NOriFvZ5fOS8K69PrALhE2h+bnH92DX/1ch38UHk2CGit9rR
 IfMJ52RHHp9ergFOnKe7CGTl6TyoLMsU/7CAgPk6lCR0cRaviWklLRNVAXztb/UlN8VR ng== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6kfenwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jun 2022 00:55:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25P0kqAN008434;
        Sat, 25 Jun 2022 00:55:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtg3ysqxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jun 2022 00:55:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eu5+oV1Uuvpgjqthn1yYa0a5BZEVNucd1vGPORbGhylTRHs2ufaARq94Dq+JppFFD/cMnOUihurGjX0WRGaDRB1t8V8DauT7uNd5EVAkR0Or4wD2RG9FY8Fb01hAz9gtdHSmBXsE1HDURIRLTO9Qr/wcIDJdfKSOHdBYZ8KY5L4Hg1G9K+MZACJ0gpVboX1/Gr7pqHLngegcXDHdbO7bvalvgRFKh0C+xctLB5/6VmL5nn3fsVCvDEFmnNbfk+be1jJvSEZ7giDIvd7p9Gi5L2n22jTs2S/flfu69A9ikFPpPHAiMqNzj96UTQthAL7bM3dSxaIUm33x0aF1/k4s4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grFiVf7aORITHzKKTetxZsI3MI3HYC4PIznIs+ILUNw=;
 b=NTIk+ywUt9lBG4eM/qen+GTS8gnZrVpgchJA+ExBtMTBJKJ1Y60z3o5AYrfIiwpHCAaFySs+6B9bVNY0GS0v8Op3m7tPArkJ0RvH2HQEJlBA4NnH6j72KeiDbzNyW13LB3SH0NjgH3ieg78LobFfcH3z0w3vLIdtBCoaYYaa2VyXTjhP6P8f79fl6GR1IUpt1rFw9dYjOJQKCM9zw9ynjHSOWRX1oGQz90zHGTRWMG1PcZxU7JzGNsfyjRsz+oCOAZdw/ZQND46yyWR9L0C63ufMhY+GrsaS19+yQw7I+6p8sj/dnRivjqX4lLq8qtQdI8E6JRUfCBcP+ISD5D3V+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grFiVf7aORITHzKKTetxZsI3MI3HYC4PIznIs+ILUNw=;
 b=m/1aBmN+XPJzItZPbwul/XJv4V9SEQfFSJLjyKPnhZg9QmQCT79G/bUUvF9VO8EGlq6uXYgknaE02eSFuMUJ5KmGWiB2WIAZUAbq9d1/vvOuvPMksKMaioLqtG0tj4DCf8bVpGElYsblpxu51nc7N39u8bmbBDmejGGlkJOOWN0=
Received: from BYAPR10MB3158.namprd10.prod.outlook.com (2603:10b6:a03:15d::23)
 by BY5PR10MB3873.namprd10.prod.outlook.com (2603:10b6:a03:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Sat, 25 Jun
 2022 00:55:39 +0000
Received: from BYAPR10MB3158.namprd10.prod.outlook.com
 ([fe80::14b1:58c6:71b4:6e7b]) by BYAPR10MB3158.namprd10.prod.outlook.com
 ([fe80::14b1:58c6:71b4:6e7b%7]) with mapi id 15.20.5353.022; Sat, 25 Jun 2022
 00:55:39 +0000
Message-ID: <3a50586afd22c1872dfe3f8fbc22438f7cb82cca.camel@oracle.com>
Subject: Re: [PATCH v2 1/1] RDMA/addr: Refresh neighbour entries upon
 "rdma_resolve_addr"
From:   Gerd Rausch <gerd.rausch@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Date:   Fri, 24 Jun 2022 17:55:34 -0700
In-Reply-To: <20220625001040.GH23621@ziepe.ca>
References: <60b4df0f7349570fe91b94eb8861043f0aba7cf2.camel@oracle.com>
         <20220624231134.GE23621@ziepe.ca>
         <101720e727de34c222ac34889b4a75ab6aec4e33.camel@oracle.com>
         <20220625001040.GH23621@ziepe.ca>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::33) To BYAPR10MB3158.namprd10.prod.outlook.com
 (2603:10b6:a03:15d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8058829c-900b-4da9-ac4d-08da56456c10
X-MS-TrafficTypeDiagnostic: BY5PR10MB3873:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vhuKLtkfeNVpFhl47HV2ZtWvX7GmvufJvyMD9c17WJVaks4XldKywJqZtXzEzifnhYBV0LAV9nwNTw4kzlrTkQKqtds7Ljo7prWUT793jTAokk+0bhM+jQ1CLhf/ruXhh732Qxo2hO+FY0D/tO6BR5GVG1jddxMAjIT9t69Yn8GXgIEKv4ppad4/Swn8DPLGe+xcUpdg4oPBgAS/FpctNJbs4ood0fn1OJHPLmuAbcnsdcmJD5pOBuw0w98435Zn2Bm+lNwHA8lXWGYbervlrbLpe6JKDPfiPDae/yu+5ucA6Utc21aOeA4AnSk9d/Ah9tvES5QPp/u5CdNKjCaNujLx6L1NgxGLIavzy9MdY6EPpVSOlayYdLJJ1Vj5vO9Y/A83ohmrlDTTCrH7/a8Lon8bUx8BM/N6AsHEtnSwoae4IniQeCV0n4b5y8FZPL2j6spbW4c2mFcMrAq1f90Tg3fQWg9iIvnmha+F6pJHOZPPJiSF8b5XhYctEYDFaxhmVOmNVZOvWiW//GsIqOcW9R6QhgCIcE0Rls4KapgQZoN6gL5JhtFivHHMBNxOeW93LBmCU/vEd6nZOLCUekIpLESuPSC3QFiQKV12I/ebbaSpeVwlHymq7iMKIAMRQvNqvPVxj9Xfldd//aCUHShSzedwsvyuTCnG6hBUhXTE4Zsj6X6UAE6OziBEQwKSLt2s8Q0zORet2REREs/WeyXx5p4eNpGJ3qzv3IwDqQdHw014XUlcP9T/X9rsY1JKeksiT1tB9Ivzd4YnCBlAF+3ZuKgoczMODCEYc6FNvvsUMXA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3158.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(376002)(396003)(366004)(136003)(478600001)(66556008)(83380400001)(4326008)(66476007)(6486002)(2906002)(8676002)(316002)(66946007)(41300700001)(8936002)(5660300002)(44832011)(52116002)(2616005)(86362001)(6512007)(6506007)(6666004)(6916009)(36756003)(186003)(38100700002)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-15?Q?UxKNYVC1bMCsbQ2AK4/HwCNJbjbsGQl2AJf5pRz09AfOdqH/L2w5dDE8D?=
 =?iso-8859-15?Q?qtZ0EaT3Tg8iZ140X9Xmv5imp6JVT8tdwFPycNlE1RDJxABWVBabjjtrb?=
 =?iso-8859-15?Q?D8tdxpyE8Dj14pstnuYFrRXPPe97Mxrcy3dhDdx8y2+5O0fk2zJQVzjaG?=
 =?iso-8859-15?Q?+mGG08n+KDnmPC5W2C5/k8xXRWZGQkGiUpNz9b9IPJPUl0FkxN3CX1iY2?=
 =?iso-8859-15?Q?D/hbpkniL9lMgm9Fi8OZo3vDzdMJRaZJ7gpUgS1Tr8XPha/v+PxyHoero?=
 =?iso-8859-15?Q?7JtFrHBBHV+tS94LXEjL3RDUA79HVhTso7UU3D/RvyvOxk97S5Wq5g82n?=
 =?iso-8859-15?Q?PNKkjj4qPM+ary8Q3oOY2qtWWRL0Cghv1rr/9wZ/cIAulJv5VYSyIhJVI?=
 =?iso-8859-15?Q?DNuXKoH6PXR5MJPrcSy03ia4mfVL3OcWuZt+X3HYv6TfqdJX/AcgERQT7?=
 =?iso-8859-15?Q?yB8BB9QQOyRu5C8ahRqqT2bkFBqyzJ0SzB7tsdjYOcaO4LLJWlectTjDp?=
 =?iso-8859-15?Q?HlQyIHGadgiQZAaefiVCFQ/fBUK1c/cVZtAYfEfaoyI2VegzR4/293/Ma?=
 =?iso-8859-15?Q?N0EWfqGyKnDmjsXsUrP/hLyIhhmRKuVfA6gtnCroiVp/7XVNquq9k9MGa?=
 =?iso-8859-15?Q?EAxWZGr5Yalla+S6jyMa9OCfs9HdIgYuDQDk9xk6hprTBLDfyuOvc21pb?=
 =?iso-8859-15?Q?qOc2hhVJSP32jWK4TosqeF40HNLhelpOuueRqe19Vl5lUkMJRzMPprMBU?=
 =?iso-8859-15?Q?OzyCF32tiW06rrJBRHe5SOA15lqse00lAwzJPDJV0tK3Du85l03sk59nU?=
 =?iso-8859-15?Q?GVizWDRU12WUN8hVeSKnLesB1zFN+GKxzU2eB/NElj3kIdjIosgD2Rjg2?=
 =?iso-8859-15?Q?c2l4f6SciwC2z/X7Dm9oCs5hd21r/5yMO302Xnm3XTTb9MDG9fdvlmi9i?=
 =?iso-8859-15?Q?k1WyMxBG6tYuhD5BsirdCBZrEYIeWBSPduY6I4ysoid+SbP/qdYqE6phG?=
 =?iso-8859-15?Q?tmc8RsK6N/5zWKkys5RfnN1WVNifvEJRPQtYTkOO3R/6wWiNwtGRvyNqL?=
 =?iso-8859-15?Q?WSfDXEdKsxeYd2bUOUNzH3OHcTVDIkA4v6qXj4ubk8I/gBPaA62kyGoHL?=
 =?iso-8859-15?Q?DCFpmOi7Fio1ZS9SJ82rqlm2qITCRB8CUxBo1zKeNYxUX/CXKvBcWkh/L?=
 =?iso-8859-15?Q?RaiuoknJaUAr9YELCmlnpeMiNGWD2eg4CbFLYlyVLpE/MT6s9nAHlsGUh?=
 =?iso-8859-15?Q?HfxDspMY2sOGYxe0sZA1zxTqjRC/pg3rm0P7O4ZGO07a/rNKW35amEluA?=
 =?iso-8859-15?Q?jEKaFcaBvAREY8JYdGFYVTtB8/WO3e8dN2JjINpk7e7SBF8m9SWdvj2gC?=
 =?iso-8859-15?Q?IR/NaunMZQkz3fapX/N/AbMkkocoyUdfPlHCn5TaC35y7/tz2fk7iahsZ?=
 =?iso-8859-15?Q?5N6hCdzo5jzd47S3ZAV30HTJp620YbkfvvVK9/jM7nsRokOemJGS5tNc9?=
 =?iso-8859-15?Q?GIBiwOUSFT/qC7MGkDZXS3Eb7x+W9kksK7I3NmV6vsYbGXrif110BOT/+?=
 =?iso-8859-15?Q?QKUaDWktguvtUNMf7ufpNfbgoeer/+glv1mIbZ4DF+pJKcXFwfRekbkMn?=
 =?iso-8859-15?Q?EPwm3r/pQzomnGC+BsKX8NmLxzN7rSZRB8SNN7L2ceUUdkQs13JrJ4VyU?=
 =?iso-8859-15?Q?dm+VoyCxcr0NLnc07ROoxo1q7cBoHe2zRDxH6yYJtkXr4oQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8058829c-900b-4da9-ac4d-08da56456c10
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3158.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2022 00:55:39.3516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+4qDQT1nSImXynDSELZj2c+vcTpuOGOHx6RpD++3qQBe7IkfEUuiPeMZ0ae3gC9eOAlykO71bEDvDIMbHlBPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3873
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-24_10:2022-06-24,2022-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=741
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206250001
X-Proofpoint-ORIG-GUID: L7VJa9m3ME6pR7hTOwDX0dc4SvNQGW0X
X-Proofpoint-GUID: L7VJa9m3ME6pR7hTOwDX0dc4SvNQGW0X
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

On Fri, 2022-06-24 at 21:10 -0300, Jason Gunthorpe wrote:
> On Fri, Jun 24, 2022 at 05:03:23PM -0700, Gerd Rausch wrote:
[...]
> > This in "dst_fetch_ha"?:
> > --------%<--------%<--------%<--------%<--------%<--------
> >         if (!(n->nud_state & NUD_VALID)) {
> >                 neigh_event_send(n, NULL);
> >                 ret = -ENODATA;
> > --------%<--------%<--------%<--------%<--------%<--------
> > 
> > With:
> > #define NUD_VALID	(NUD_PERMANENT|NUD_NOARP|NUD_REACHABLE|NUD_PROBE
> > > NUD_STALE|NUD_DELAY)
> > 
> > and the knowledge that the ARP entry is NUD_STALE,
> > how would that function be called and perform the necessary refresh?
> > 
> > 
> > > I think there is more going on here than this commit message is
> > > explaining.
> > > 
> > 
> > If the intention of the above mentioned "neigh_event_send" was to
> > refresh stale entries, then the "if" condition ought to change, no?
> 
> Maybe yes.
> 
> If you are saying with this patch that neigh_event_send() should be
> called unconditionally for every 'packet' why not remove the test
> above instead of calling it twice?
> 

It looks like starting from the very first time when "neigh_event_send"
was introduced here:

935ef2d7a291 RDMA/cma: Use neigh_event_send() to start neighbour discovery

it was always strictly coupled to the "-ENODATA" case.

In other words, I don't see how the STALE case was covered, and I'd have
to guess wether the -ENODATA coupling was intentional or accidental.

Now it may be perfectly possible to just make the "neigh_event_send"
call above unconditional and call it a day.

I mean, simpler fixes always win over more complex ones.

But, I personally don't know the twists & turns of this code well enough
to be able to assert that this won't leave any non-covered conditional
corner cases. I certainly hadn't tested that.


> On the other hand I see many places checking for NUD_VALID before
> calling it.
> 
> So, really the commit message needs to explain how neigh_event_send()
> is supposed to be used and explain that NUD_VALID is OK to drop.
> 

Some places do check for NUD_VALID (e.g. "__ip_do_redirect"),
many others don't (e.g. "__teql_resolve", or "neigh_resolve_output"
itself).

Even in the case of "dst_fetch_ha":
I can not state whether the check for !NUD_VALUD was done intentionally
or not. I can observe though that the side-effect of that check is that
STALE entries won't get refreshed. So something is clearly off here.

Let's look "__ip_do_redirect":
I would have to guess why that check for !NUD_VALID is there.
It's been there as far back as the GIT history goes.
But I prefer not having to put guess-work into my Commit-Log.

That said, I don't mind putting guess-work in this e-mail though:
Perhaps the author(s) knew that the code would have to go through
"ip_finish_output2" (or whatever the predecessor's name was) eventually,
and therefore it was okay to kick off a refresh only if !NUD_VALID.

At the end of the day, if the desired behavior is to always refresh
STALE entries, we should do so.
Calling "neigh_event_send" for !NUD_VALID only won't achieve that.

> I'm having a hard time guessing from a quick look around.
> 

Thanks for looking though,

  Gerd


