Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C27B383C99
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 20:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbhEQSpo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 14:45:44 -0400
Received: from mail-bn7nam10on2046.outbound.protection.outlook.com ([40.107.92.46]:4024
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234106AbhEQSpn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 May 2021 14:45:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQ+RwEDqC1NIJNbPiiM9nKwN4IxB2uyo0j9HxbVMFFh1CjvrnPkCPEDLtAj7woiDGmlVlvJdtYOkgfrRH5t1OueYbnOworgX2v6ICco5d3jb+TPSUsRzo+dtxBfZSI9/AAz+idL7vurPxl0kcnt+B100x8/2802S5f0VVvIZdeR7kWvHAsghfPBa++BGrQqbB/3JfeNgk2qNiUsxUX17EKdlD8jMnuxOeDlQ/jGovhRQ7KqgY/8HG3EvDipfhCyyP4GVff1+FdBFETE3CyHNvBicShABbG5a+08RQb0a/5+AUqaVvVN7srsuQNy516KuE4f1/lcF+9VgO2pk8xg80w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpMwb1JmCvV6DSHj9V0PJYc1yGYzQ0kMvcCSuuRsEHg=;
 b=MYE/DkdHk5OkIibWwE+jaNWZ7cz7acqAr+ShBByY6X4v5nD5Ile7uaHwYH3aw1qJdRxBHLbJUZYTXhitUXmq+xQWbc9qGUnkGdWaen7ybywBvx72GEoxJUd2UzVaXlsUwNNyVXv8lyPptqJNBtyKWwwipWnxsnozNgD8uLZDlCa6mzimFRkrix1sLCgKxGB+sseGe+Eazt8R7O/q6Lob2n+YeTYCmWtii6gt1aCOl/BnrDh2MecdCrZlMTG/lyWaY3s6NUm7PXtAv3VPmnXCm2vLkbW1vICijrSKlOtLEAZf6te9YRaPeC1gQPSsQt1OU5z1jq91qgTXlSAYMxSixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpMwb1JmCvV6DSHj9V0PJYc1yGYzQ0kMvcCSuuRsEHg=;
 b=eJxwoLLMF9/75qEgGVXuU/4/7b0B/GFSSxBEg1yD8u1JNqVrrIvswUiRCbLfVivtAzKO2OT+9F0HEhFlE4MFdqUoNCmA3sp1fUFRLF19GhEntziQErCw7PPzhS08OZb7qxlx6OkKSJY6KZtslTbUnWPXNNY7lmP2vWec3WIldKjYgfe1Uo5XJnKpQHSlqW5pmheo0y8+vf+K/twa95ZTaG3XDqdm4ma0U5Sf/+dWjjE3Tkp8qDc1qvHQ7fP46Q/MgyHNeiphtiB9TQoUT+MbgVCbM9YNthNRmASlYFahN/dKC3q5F6/ymkIO6zvSPQas0aKcvRZqPKPFJAepM1Z5dg==
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Mon, 17 May
 2021 18:44:25 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 18:44:25 +0000
Date:   Mon, 17 May 2021 15:44:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 11/13] RDMA/qib: Use attributes for the port sysfs
Message-ID: <20210517184423.GU1002214@nvidia.com>
References: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <11-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <YKKj2Fx+9t0KnoGr@kroah.com>
 <20210517171347.GS1002214@nvidia.com>
 <YKKoclygfHI5uUbo@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKKoclygfHI5uUbo@kroah.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:208:23b::8) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR11CA0003.namprd11.prod.outlook.com (2603:10b6:208:23b::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 18:44:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1liiE3-009mJb-Hu; Mon, 17 May 2021 15:44:23 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db361f1e-8fe0-4c9d-573a-08d91963cb37
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-Microsoft-Antispam-PRVS: <DM5PR12MB188234860BEEA806F89D5EEAC22D9@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4SYoFakto1yjHRMhaImIOd5O2ihgBI/I4uvwylCXYXyGUBucgiBuvZEg/tc/D4wXKN/Iv6ZZVJOcu33tNJqZXj8JfqJZM8s2VSypjDKBPDsKaWSWvfTx40Es9phah6C9Amm8FDYnWeM483b9Hs7368RpEmmmwBZAhlCEq2qdCCA8EYYIpqvR4wznLmV8VZZ+9v4b/wsvhveFpQRAR5vvDki7F6BT2LwjzjBJVo8CP4B5GnhSgoHcGax0BjpLUlTZYY4zA9KvgqBVK9OTqsD9B3aP/YPtHNSAPYHKFEDF/jI6OEmp1fKa5EmT6XgfADf2wbxgS+qVbhs4a7fo4n1N3gdKRmmlv3YjReYXVkXTemqyIgyrgf7p/VOFUcPHQ/36FZPc89OFhONQsmi5wskc6HsPNH+ksZyPqMYl5MIDElJ8kuvr0k8+NevtfROamn6d2L5P+YYejnhlzmEjUdZl0K6DbQyRaSwx2j2NsRF3k9t0TObHLYyNs/Mh/4ZwHoygJwjxsgBgfVQKDXlK9ER8KsPI3YETzSeQ8SvQJyIsc0i3qOXdk0dkKsCHhA2QBHJITnO+W2fWoDvMAEGaGtda8xHYovVDMZzYptK/CTvAoPs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(8676002)(186003)(9746002)(4326008)(38100700002)(9786002)(426003)(86362001)(8936002)(2616005)(54906003)(2906002)(66556008)(26005)(33656002)(83380400001)(1076003)(316002)(5660300002)(478600001)(36756003)(6916009)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QqO5sWVCngOF1nCL0x6LRfRWghKFK0XJfAKEHL7QgyavRLsWqLXfkWg4/B+p?=
 =?us-ascii?Q?lVYvIE+076vzPLl6px3Sh9o2BccPj4LsN7ZkQKlzqsoeJq8UPzvO3kUw3jhM?=
 =?us-ascii?Q?WYopmDQvYBqNTW0s1U0L4ifYoH0xfZlbt07U36/Q54BuNoKJyrdRLL2lEatb?=
 =?us-ascii?Q?EMIO6hCCGH3bI7dyKxcSjoBL9Mo64DkUxbGnQ0/HTsjzR2cT3Tmg5qWISCHN?=
 =?us-ascii?Q?xVeoC9Nnj/bbkQJLZwV0w+ELUYsBfHCHCcGKaujePRHbG6p0qjbj/cBmW3jm?=
 =?us-ascii?Q?WZ/8l8SBS+NB6kmnCT9gGLLUzQaDlJ79lPvH7ddFDFhnpOHC+SvctrkAKXpm?=
 =?us-ascii?Q?VYJBRAHTPzYOPbdRhEePImBTgvN2GvHROSItmJQE2IfrK73TkKHraTmM8fN2?=
 =?us-ascii?Q?ACs+pXAUOtdP+r9AQIirQPUdbKIe8t/FXnnjtw5MG4PIz317egrQpYNLfRO5?=
 =?us-ascii?Q?/7XVCBAwwgR2KdnfLtm9KkWTTVDlD54MRubgcCiXJbDzRKECi52G7Re/cjxH?=
 =?us-ascii?Q?ccg/Biv4A8yUpbaKOQneL0nKl1OwpMiTo17HTG1xShX1jAEiVbkIe3gV7TLj?=
 =?us-ascii?Q?xddO/n5xG8Qeh6adxZKmOhdD6TqqX7ijmyK1LN1HUFVfCXU5TqoHriJrpzMG?=
 =?us-ascii?Q?BfWyEWypGeTlgCpWgEiGP/MoJvST4BEMv9xaaLlAwlWo8syER2KdhgOP5D8p?=
 =?us-ascii?Q?r9bkR7+OLWnlWVoxcVKFxvLLZZ8m6MTqpCzcHRskHIz7c53pIToi2LqI/fBm?=
 =?us-ascii?Q?aoxsCO89MU9pJ98D1uao2c6qfXmpWvcKKfVMH1WLFBU3LyL7caX9RlVZwCy7?=
 =?us-ascii?Q?jhMCrwjjG51B2NsozCxPEcijHCQ/1vgxriIpEVehE7WHtpcVAbO1QafituOL?=
 =?us-ascii?Q?Zv8G7BkTxFEQ7ZmaRIrZfp+R4gvVExrOWWHTjz+HfMeMwYH2Av2Tv70Ne7TI?=
 =?us-ascii?Q?gGmspawiiGj3DweLfNjxFRO6xCJhzBaaMmP3c1KWDI0e5sZNWlhRcxJ7brJd?=
 =?us-ascii?Q?XRwopmCn3BoDhIWNAveXOgfqDJsKL61vmh7VM4gpE7NcqB7pCLHXTOuYNEdb?=
 =?us-ascii?Q?bXGGgoqNIK/mX7OwjhHX1OsfW0PdvnSRpbaz4Sqp89XY747nGPKcnGi8X224?=
 =?us-ascii?Q?vm6UxnbApy52ofMYfDS1MwEkoCgZ4mO7/qTVq/RK37qXb9I8CxaSv1FKe/90?=
 =?us-ascii?Q?jW/UuiRzessJ+k1hMalYFc+G58q+7tmroddm3ENYh7OtNMw/00Z5Z3T5x9cj?=
 =?us-ascii?Q?SScGRhFib/W3gEkfskIF8aXL4YgiuutKJQkrcrvJYlf13sJvAAXkQribUTXg?=
 =?us-ascii?Q?W6LPg1S1pSx0Z5lvNoPbgMl4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db361f1e-8fe0-4c9d-573a-08d91963cb37
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 18:44:25.2953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPKrb2LS9mK+B0/BJael+gzdZuOrDQzwXhdYDQbNC6SBIY5WG3g/Ig5fuh6Ba0Bk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 17, 2021 at 07:31:30PM +0200, Greg KH wrote:
> On Mon, May 17, 2021 at 02:13:47PM -0300, Jason Gunthorpe wrote:
> > On Mon, May 17, 2021 at 07:11:52PM +0200, Greg KH wrote:
> > > On Mon, May 17, 2021 at 01:47:39PM -0300, Jason Gunthorpe wrote:
> > > > qib should not be creating a mess of kobjects to attach to the port
> > > > kobject - this is all attributes. The proper API is to create an
> > > > attribute_group list and create it against the port's kobject.
> > > > 
> > > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > > >  drivers/infiniband/hw/qib/qib.h       |   5 +-
> > > >  drivers/infiniband/hw/qib/qib_sysfs.c | 596 +++++++++++---------------
> > > >  2 files changed, 248 insertions(+), 353 deletions(-)
> > > > 
> > > > diff --git a/drivers/infiniband/hw/qib/qib.h b/drivers/infiniband/hw/qib/qib.h
> > > > index 88497739029e02..3decd6d0843172 100644
> > > > +++ b/drivers/infiniband/hw/qib/qib.h
> > > > @@ -521,10 +521,7 @@ struct qib_pportdata {
> > > >  
> > > >  	struct qib_devdata *dd;
> > > >  	struct qib_chippport_specific *cpspec; /* chip-specific per-port */
> > > > -	struct kobject pport_kobj;
> > > > -	struct kobject pport_cc_kobj;
> > > > -	struct kobject sl2vl_kobj;
> > > > -	struct kobject diagc_kobj;
> > > > +	const struct attribute_group *groups[5];
> > > 
> > > As you initialize these all at once, why not just make this:
> > > 	struct attribute_group **groups;
> > > 
> > > and then set the groups up at build time instead of runtime as part of a
> > > larger structure like the ATTRIBUTE_GROUPS() macro does for "simple"
> > > drivers?  That way you aren't fixed at the array size here and someone
> > > has to go and check to verify you really have properly 0 terminated the
> > > list and set up the pointers properly.
> > 
> > qib has a variable list of group memberships that can only be
> > determined at runtime:
> > 
> >         if (qib_cc_table_size && ppd->congestion_entries_shadow)
> >                 *cur_group++ = &port_ccmgta_attribute_group;
> > 
> > So it can't be setup statically at compile time.
> 
> That attribute group can have a is_visable() callback to allow those
> files to show up or not, instead of having to determine this when you
> are setting up the list of groups.

Okay, that looks like it will work out and will be less complicated
code in a driver, and I can get rid of a function callback. See below

> But that's your call, not a big deal, overall this series looks like a
> lot of good cleanups to me, thanks for doing it.

No problem, it deletes a lot of horrible code. Every time I looked at
this in the past I wanted to poke at it. When Kee's pointed out what
it was doing it was just the last straw. I didn't expect it to expand
into cm, qib and hfi1 though..

Thanks,
Jason

diff --git a/drivers/infiniband/hw/qib/qib.h b/drivers/infiniband/hw/qib/qib.h
index 3decd6d0843172..b8a2deb5b4d295 100644
--- a/drivers/infiniband/hw/qib/qib.h
+++ b/drivers/infiniband/hw/qib/qib.h
@@ -521,7 +521,6 @@ struct qib_pportdata {
 
 	struct qib_devdata *dd;
 	struct qib_chippport_specific *cpspec; /* chip-specific per-port */
-	const struct attribute_group *groups[5];
 
 	/* GUID for this interface, in network order */
 	__be64 guid;
diff --git a/drivers/infiniband/hw/qib/qib_sysfs.c b/drivers/infiniband/hw/qib/qib_sysfs.c
index 2c81285d245fa7..a1e22c49871266 100644
--- a/drivers/infiniband/hw/qib/qib_sysfs.c
+++ b/drivers/infiniband/hw/qib/qib_sysfs.c
@@ -282,8 +282,19 @@ static struct bin_attribute *port_ccmgta_attributes[] = {
 	NULL,
 };
 
+static umode_t qib_ccmgta_is_bin_visible(struct kobject *kobj,
+				 struct bin_attribute *attr, int n)
+{
+	struct qib_pportdata *ppd = qib_get_pportdata_kobj(kobj);
+
+	if (!qib_cc_table_size || !ppd->congestion_entries_shadow)
+		return 0;
+	return attr->attr.mode;
+}
+
 static const struct attribute_group port_ccmgta_attribute_group = {
 	.name = "CCMgtA",
+	.is_bin_visible = qib_ccmgta_is_bin_visible,
 	.bin_attrs = port_ccmgta_attributes,
 };
 
@@ -534,6 +545,14 @@ static const struct attribute_group port_diagc_group = {
 
 /* End diag_counters */
 
+static const struct attribute_group *qib_port_groups[] = {
+	&port_linkcontrol_group,
+	&port_ccmgta_attribute_group,
+	&port_sl2vl_group,
+	&port_diagc_group,
+	NULL,
+};
+
 /* end of per-port file structures and support code */
 
 /*
@@ -718,19 +737,7 @@ const struct attribute_group qib_attr_group = {
 int qib_create_port_files(struct ib_device *ibdev, u32 port_num,
 			  struct kobject *kobj)
 {
-	struct qib_devdata *dd = dd_from_ibdev(ibdev);
-	struct qib_pportdata *ppd = &dd->pport[port_num - 1];
-	const struct attribute_group **cur_group;
-
-	cur_group = &ppd->groups[0];
-	*cur_group++ = &port_linkcontrol_group;
-	*cur_group++ = &port_sl2vl_group;
-	*cur_group++ = &port_diagc_group;
-
-	if (qib_cc_table_size && ppd->congestion_entries_shadow)
-		*cur_group++ = &port_ccmgta_attribute_group;
-
-	return ib_port_sysfs_create_groups(ibdev, port_num, ppd->groups);
+	return ib_port_sysfs_create_groups(ibdev, port_num, qib_port_groups);
 }
 
 /*
@@ -740,10 +747,7 @@ void qib_verbs_unregister_sysfs(struct qib_devdata *dd)
 {
 	int i;
 
-	for (i = 0; i < dd->num_pports; i++) {
-		struct qib_pportdata *ppd = &dd->pport[i];
-
+	for (i = 0; i < dd->num_pports; i++)
 		ib_port_sysfs_remove_groups(&dd->verbs_dev.rdi.ibdev, i,
-					    ppd->groups);
-	}
+					    qib_port_groups);
 }
