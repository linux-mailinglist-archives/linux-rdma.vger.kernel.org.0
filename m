Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA34936B5EB
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Apr 2021 17:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbhDZPif (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Apr 2021 11:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbhDZPif (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Apr 2021 11:38:35 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86435C061574
        for <linux-rdma@vger.kernel.org>; Mon, 26 Apr 2021 08:37:53 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h8so26142118edb.2
        for <linux-rdma@vger.kernel.org>; Mon, 26 Apr 2021 08:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Wrvyd4ArpYGa1AlI14aAC0Av6u8JzqpTAEzCkBVExqY=;
        b=gG36AGpV41evZXdnS2gdWza3TGn33Y33MLTncJKqtnjXJaO6Jmr1W+qKhGiTM50qvE
         ryIKbeiHdmXum4P7+yM4Esoy6muunjHKxSvfSYwun3Q4AeVDJI3lJdJVDO/A1odDlKXA
         Ao8p9R1cBvOOy8KZ2g7t3TwvDmoDorQ6lNOXGiE65wpzbmufa74K8MKnAlb06iWSKC7/
         F55BdEJeHgzYRF8VCY8U9wGq/TcAlByuzpetZULh1TAVDo3gGbra0eCkWhxn5+Fz9B0O
         cfEz/0Ht7ozEAP+N9F+/OQijCPo6jfOs46RA39CwV8HLd8BG5vyEGNJBOb4y1mGNoZLK
         ykBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Wrvyd4ArpYGa1AlI14aAC0Av6u8JzqpTAEzCkBVExqY=;
        b=VFM6y4B15mmnkSMAJ2wBNSahqLrVG6vg035BVeyLb6jx+eRoOndiRcLwVs1+6HxWKW
         0WO24poIGY/DF0epxmy3VXjsua2cmOnVwYxOLLEfBf+qmgTWYKw3j/nvBYANN/qtJR73
         eALc9m3vH2oZ8uG19c5ohfzAAj/cbAQ51rRCKcr70tjwZx9Hcw4ElPEpJ+v1xGj92ytI
         sZpBPjlOHjMk0JYGEqiVf/6/ogP9b78QAX7azZk3f7mD/YZ+EWuVPR+ZpI3mIAlX3Uau
         daK7iXH+IUWdunIki6XQfK+THiU6gkQU4epiNLzCaZR+ozrJSRBsQ/rN5+B55BJxR25B
         /QCg==
X-Gm-Message-State: AOAM532wCHkHbJJwpnVccFskwxDj3J0hEWhTkWA3VhEVYKodrxUAaWCW
        wGV97s5pc5HXDZ5zlKiBCJQpA4/4u6H3SRmu
X-Google-Smtp-Source: ABdhPJyXAOKqUh9oeNJS4JnQ6ij2hipCwWOuaiaGOnL2OR8SuQQT5YCkWEDOdjQKzMxrRm0wIVGEKA==
X-Received: by 2002:a05:6402:cb3:: with SMTP id cn19mr21826883edb.206.1619451472262;
        Mon, 26 Apr 2021 08:37:52 -0700 (PDT)
Received: from [192.168.3.162] (ip5b401b0e.dynamic.kabel-deutschland.de. [91.64.27.14])
        by smtp.gmail.com with ESMTPSA id x9sm157454edv.22.2021.04.26.08.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 08:37:51 -0700 (PDT)
Message-ID: <89ade01d546b812a9e97c0481d5846000c1a180a.camel@ionos.com>
Subject: Re: rdma-core: Minimum supported Debian & Ubuntu releases
From:   Benjamin Drung <benjamin.drung@ionos.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Date:   Mon, 26 Apr 2021 17:37:51 +0200
In-Reply-To: <20210426124902.GJ2047089@ziepe.ca>
References: <8d930476e5daf34147a178420596230dfecf2038.camel@cloud.ionos.com>
         <YHQttR48FsDJkuWd@unreal> <20210413164012.GJ227011@ziepe.ca>
         <84ac2b08ac7440b12ddca7da7e722168cc15cd32.camel@ionos.com>
         <20210426124902.GJ2047089@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am Montag, den 26.04.2021, 09:49 -0300 schrieb Jason Gunthorpe:
> On Mon, Apr 26, 2021 at 11:12:50AM +0200, Benjamin Drung wrote:
> > Am Dienstag, den 13.04.2021, 13:40 -0300 schrieb Jason Gunthorpe:
> > > On Mon, Apr 12, 2021 at 02:23:33PM +0300, Leon Romanovsky wrote:
> > > > On Mon, Apr 12, 2021 at 12:31:26PM +0200, Benjamin Drung wrote:
> > > > > Hi,
> > > > > 
> > > > > which Debian & Ubuntu releases should rdma-core support? Do
> > > > > we
> > > > > have a
> > > > > policy for that like all LTS versions?
> > > > 
> > > > I don't think that we have a policy for that.
> > > 
> > > I understand there are still active users on the prior LTS, so I
> > > would
> > > prefer to keep that working.
> > 
> > So to put numbers on it. rdma-core should support:
> > 
> > * Debian 9 (stretch) or newer
> > * Ubuntu 18.04 LTS (bionic) or newer
> > 
> > Debian 9 is currently oldstable and Ubuntu 18.04 LTS is the second
> > newest Ubuntu LTS version. Or do you refer to Debian 8 "jessie"
> > (which
> > EOL last year) and Ubuntu 16.04 LTS (EOL around now)?
> 
> Yes 16.04 :( Maybe it is nearing dead now, but if we don't have a
> strong reason to kill it I'd prefer to leave it be. Basically if it
> is in buildlib/azure-pipelines.yml it should work.
> 
> Even centos6 is still in active use for some reason, and our
> container
> images for it can't even be built anymore :\
> 
> I don't have any info on Debian users.

Okay, so the known supported versions are:

* Debian 9 (stretch) or newer
* Ubuntu 16.04 LTS (xenial) or newer

There are a few changes between the master branch and debian/master: 

* Upgrade debhelper from 9 to 13
* Drop debug symbol migration

These changes will need to live in this branch for quite some time.

-- 
Benjamin Drung

Senior DevOps Engineer and Debian & Ubuntu Developer
Compute Platform Operations

1&1 IONOS SE | Greifswalder Str. 207 | 10405 Berlin | Deutschland
E-Mail: benjamin.drung@ionos.com | Web: www.ionos.de

Hauptsitz Montabaur, Amtsgericht Montabaur, HRB 24498

Vorstand: Hüseyin Dogan, Dr. Martin Endreß, Claudia Frese, Henning
Kettler, Arthur Mai, Matthias Steinberg, Achim Weiß
Aufsichtsratsvorsitzender: Markus Kadelke


Member of United Internet


