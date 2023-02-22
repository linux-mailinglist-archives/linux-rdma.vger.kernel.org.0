Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED8C69F7AE
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Feb 2023 16:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjBVPZH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Feb 2023 10:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBVPZG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Feb 2023 10:25:06 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365F236FFA;
        Wed, 22 Feb 2023 07:25:05 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MEbtPh001967;
        Wed, 22 Feb 2023 15:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=2u3wfG/YjRdUxLDNaAK1qN5vV7Op3y/upBI7BXKxu8Y=;
 b=szXXQ0tUICqnWzWknQn51Wp+TPJb5OBixTOWJTYh8DPK5nfURlpNHBMON/Jg/PvVM8aq
 ANH7oUswblq4XzyyccuGcpbt4e/xsYKjABynqS0+w5AUBgc8vbcZUXh+POf5kHZ8dgeG
 VJQ3uc3a4pya67zzoFBboBMfY/PYSy/17WOs1cRb0+CGa3NMJraIaIp56IyoCMVyR0gA
 RvvG3mq2ttJwIVL7fGGj83Lb7aCz70eFfq538u9xQXgxq04pz/UEa/5rwZdz0nGnvUkZ
 FlfR7GLgHdoIecBHeLfCZiiP06m9L+1/MPKKlyOJ2RapY4vkf9ZHuVGo/fCLvfBfwu2R aQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwmyr9bjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 15:24:44 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31MFMqBU032503;
        Wed, 22 Feb 2023 15:24:43 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwmyr9bhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 15:24:43 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31MDIbRV015818;
        Wed, 22 Feb 2023 15:24:42 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3ntpa70xcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 15:24:42 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31MFOfGZ64356814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 15:24:41 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67CA55805F;
        Wed, 22 Feb 2023 15:24:41 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4ED0358043;
        Wed, 22 Feb 2023 15:24:40 +0000 (GMT)
Received: from sig-9-65-243-31.ibm.com (unknown [9.65.243.31])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Feb 2023 15:24:40 +0000 (GMT)
Message-ID: <5785f9eff97341214e81a1950ac6a4d2ce0cef8d.camel@linux.ibm.com>
Subject: Re: [PATCH 4.19 v2 0/5] Backport handling -ESTALE policy update
 failure to 4.19
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     GUO Zihua <guozihua@huawei.com>, paul@paul-moore.com
Cc:     linux-security-module@vger.kernel.org, linux-rdma@vger.kernel.org,
        dledford@redhat.com, jgg@ziepe.ca
Date:   Wed, 22 Feb 2023 10:24:39 -0500
In-Reply-To: <20230216124227.44058-1-guozihua@huawei.com>
References: <20230216124227.44058-1-guozihua@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gZ84qKvd0rBbIWN5x9BNVRfBowKzEFIm
X-Proofpoint-ORIG-GUID: oJPMTlt1P02RkyEVGkLNf6kpXAbVsFS1
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1011 impostorscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220131
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Scott,

On Thu, 2023-02-16 at 20:42 +0800, GUO Zihua wrote:
> This series backports patches in order to resolve the issue discussed here:
> https://lore.kernel.org/selinux/389334fe-6e12-96b2-6ce9-9f0e8fcb85bf@huawei.com/
> 
> This required backporting the non-blocking LSM policy update mechanism
> prerequisite patches. As well as bugfixes that follows.

For ease of reading, the above sentence should end with a colon and be
followed with the list of commits.
> 
> 66f67414c1f ("IB/core: Don't register each MAD agent for LSM notifier")
> is merged as the prerequisite of 42df744c4166 ("LSM: switch to blocking
> policy update notifiers"). 

> e144d6b26541 ("ima: Evaluate error in
> init_ima()") is merged as a follow up bugfix for b16942455193 ("ima:
> use the lsm policy update notifier").

> 483ec26eed42 ("ima: ima/lsm policy
> rule loading logic bug fixes") and 9ff8a616dfab ("ima: Have the LSM free
> its audit rule") is also followup bugfixes. The former would change the
> behavior of rule loading without fixing any criticial bug so I don't
> think it's necessary, while the latter has already been merged.

Prior to the non-blocking LSM notifier was upstreamed, a custom IMA
policy with LSM  based policy rules could not be loaded until the LSM
policy had been initialized.  Commit 483ec26eed42 ("ima: ima/lsm policy
rule loading logic bug fixes") reverts the unintended change in
behavior.

> 
> I've tested the patches against said issue and can confirm that the
> issue is fixed.
> 
> This is a re-send of the original patchset as the original patchset
> might have a faulty cover letter. The original patchset could be found
> here:
> https://patchwork.kernel.org/project/linux-integrity/list/?series=709367

In addition to a "faulty cover letter", included in this version
additional patches are being backported.

Probably better to drop this comment or to include a "Link:" to the
mailing list discussion, as described in
Documentation/process/submitting-patches.

> 
> Change log:
>   v2: Fixed build issue and backport bugfix commits for backported
> patches.
> 
> Daniel Jurgens (1):
>   IB/core: Don't register each MAD agent for LSM notifier
> 
> GUO Zihua (1):
>   ima: Handle -ESTALE returned by ima_filter_rule_match()
> 
> Janne Karhunen (2):
>   LSM: switch to blocking policy update notifiers
>   ima: use the lsm policy update notifier
> 
> Roberto Sassu (1):
>   ima: Evaluate error in init_ima()
> 
>  drivers/infiniband/core/core_priv.h |   5 +
>  drivers/infiniband/core/device.c    |   5 +-
>  drivers/infiniband/core/security.c  |  51 +++++-----
>  include/linux/security.h            |  12 +--
>  include/rdma/ib_mad.h               |   3 +-
>  security/integrity/ima/ima.h        |   2 +
>  security/integrity/ima/ima_main.c   |  11 ++
>  security/integrity/ima/ima_policy.c | 151 ++++++++++++++++++++++------
>  security/security.c                 |  23 +++--
>  security/selinux/hooks.c            |   2 +-
>  security/selinux/selinuxfs.c        |   2 +-
>  11 files changed, 193 insertions(+), 74 deletions(-)
> 
-- 
thanks,

Mimi

