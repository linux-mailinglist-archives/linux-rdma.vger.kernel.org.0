Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4D36A5FE7
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Feb 2023 20:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjB1TqT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Feb 2023 14:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjB1TqS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Feb 2023 14:46:18 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934AE1BAFE;
        Tue, 28 Feb 2023 11:46:17 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31SIJv9g006935;
        Tue, 28 Feb 2023 19:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=zXLbJQnUztunJ+IAJYxPhkwQ5LnDz7KnX8kAeWB2rW4=;
 b=Ggrm3lPbk1/rNbTtyitCi88YinILxdnxMB//+SvZRyK9MMzMB8QOWwjsgtWsmY6KQz2F
 ciVcf46rWI1Oo/z7a6XYloPb8cOKwe1ieKccPndkCFIoOC5cV5v3b/WKjU/yzecYip+A
 0iCs2t1ZRI1N4f5Fl7DGghfWbwGeL78R+ehBEb/O8DStyxcaqAEkoE5TTzlRSuddYCqQ
 w7WRlotluHx91kqCpxbQSKWepk4x3hyGJ2Bj+WXDT3I6SohJ/UtzUuluZLG6YK/fo/yl
 uEAfRXqIv9wliGvGglvrDZzXUbSlqMphwOx0vgHfwJ0nYPvYm0kL7sF9gyYkhmmt22Lf Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p1pswjg6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 19:46:08 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31SIKV2v008505;
        Tue, 28 Feb 2023 19:46:08 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p1pswjg6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 19:46:08 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31SIna7q024474;
        Tue, 28 Feb 2023 19:45:07 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3nybe9js7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 19:45:07 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31SJj6QD7471674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 19:45:06 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C9B75805C;
        Tue, 28 Feb 2023 19:45:06 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F0FE58051;
        Tue, 28 Feb 2023 19:45:05 +0000 (GMT)
Received: from sig-9-65-248-59.ibm.com (unknown [9.65.248.59])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 28 Feb 2023 19:45:05 +0000 (GMT)
Message-ID: <57ebd18a95caa0a8df9ad542478d5dca3ff5760c.camel@linux.ibm.com>
Subject: Re: [PATCH 4.19 v3 0/6] Backport handling -ESTALE policy update
 failure to 4.19
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>, GUO Zihua <guozihua@huawei.com>
Cc:     linux-security-module@vger.kernel.org, linux-rdma@vger.kernel.org,
        dledford@redhat.com, jgg@ziepe.ca
Date:   Tue, 28 Feb 2023 14:45:04 -0500
In-Reply-To: <CAHC9VhR1UxGQnsWU1bhG1_XMVfdt_j-cVZkKnQ+rjzqcEP_NHw@mail.gmail.com>
References: <20230228080630.52370-1-guozihua@huawei.com>
         <CAHC9VhR1UxGQnsWU1bhG1_XMVfdt_j-cVZkKnQ+rjzqcEP_NHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QyVMhysK9XYRtHg8Eq-M0c1YYVoXsWzk
X-Proofpoint-ORIG-GUID: xsW4uq7gDxrB2Uc1jJH5xv_A_AHr3tk3
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_15,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302280162
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 2023-02-28 at 11:25 -0500, Paul Moore wrote:
> On Tue, Feb 28, 2023 at 3:09 AM GUO Zihua <guozihua@huawei.com> wrote:
> >
> > This series backports patches in order to resolve the issue discussed here:
> > https://lore.kernel.org/selinux/389334fe-6e12-96b2-6ce9-9f0e8fcb85bf@huawei.com/
> >
> > This required backporting the non-blocking LSM policy update mechanism
> > prerequisite patches. As well as bugfixes that follows:
> >
> > c66f67414c1f ("IB/core: Don't register each MAD agent for LSM notifier")
> > 42df744c4166 ("LSM: switch to blocking policy update notifiers")
> > b16942455193 ("ima: use the lsm policy update notifier")
> > 483ec26eed42 ("ima: ima/lsm policy rule loading logic bug fixes")
> > e144d6b26541 ("ima: Evaluate error in init_ima()")
> > c7423dbdbc9e ("ima: Handle -ESTALE returned by ima_filter_rule_match()")
> >
> > c66f67414c1f ("IB/core: Don't register each MAD agent for LSM notifier")
> > is merged as the prerequisite of 42df744c4166 ("LSM: switch to blocking
> > policy update notifiers"). e144d6b26541 ("ima: Evaluate error in
> > init_ima()"), 483ec26eed42 ("ima: ima/lsm policy rule loading logic bug
> > fixes") and 9ff8a616dfab ("ima: Have the LSM free its audit rule") are
> > merged as a follow up bugfix for b16942455193 ("ima: use the lsm policy
> > update notifier").

Scott, there's no need to duplicate the list of commits like this. 
Having an unordered list would have been fine.

> >
> > I've tested the patches against said issue and can confirm that the
> > issue is fixed.
> >
> > Link to the original maillist discussion:
> > https://lore.kernel.org/all/389334fe-6e12-96b2-6ce9-9f0e8fcb85bf@huawei.com/
> >
> > Change log:
> >   v2: Fixed build issue and backport bugfix commits for backported
> > patches.
> 
> Is there a quick summary of the changes in v3 of this patchset?

v3:  Backport commit 483ec26eed42b ("ima: ima/lsm policy rule loading
logic bug fixes")  as well.

-- 
thanks,

Mimi


