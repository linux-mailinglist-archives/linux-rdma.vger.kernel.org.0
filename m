Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2213D48523F
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 13:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239943AbiAEMFM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 07:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239944AbiAEMFL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 07:05:11 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A5EC061785
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jan 2022 04:05:10 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id e5so82525009wrc.5
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jan 2022 04:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=S/RIfb10IzRTcG4cTWIvrM+GCRkBu/G++RQWnnEBpOs=;
        b=GibiJBvNi9nFJTKVABwN4peXjzOuYfwh+e/WmT5uIjWl9cf8sGEqmOurwSU7ZUCPoO
         hUOXFrzEhq+O7sPDEJSSQ7/0UBPrQbNC5Nn2T530f1irBudLgN+AMaJt0XjI1nM6aCwG
         9BOShRx/qWnu3aDiz4b97PqWoGrmo/Hk45G60Ov+YQvIKW48rxr2KUt3om9UDbl8jXKS
         oiJMNk827xW4m/jfN9TcEyXM9ghGK0XnGwtcvXTXSexHw85+KbvkJt7MMUZ188IeBTQx
         VSOwx9cuPrf/sV97/H8UZfOEvvDucUE/ppAOcoJgn4Xfv98XGa+Hx6ymJKTR6kBj+KWn
         +w0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=S/RIfb10IzRTcG4cTWIvrM+GCRkBu/G++RQWnnEBpOs=;
        b=JNSyt4RMbZpouRvnebK7oevUlks+xTKxwv8KU1+BYIQKjFOSA3VG2DBWi3pHIQ6CDI
         ITm6FajT5+vD3o+YjZl8cem3iPpA44WJ5pc36GV/AMFDrbbUJ3U5BTgWQ0xQKts81Y07
         H+qyVYM9S8w8EWCvXDw1NVKHPj5WAro+wD5d57rpEkFEub4UgAPGCD2Ed1J0USKmY9ew
         1Fj9OV9EbI78sw0knBhN+KTZtILQIXq0ZKe/AEzmSrmp7eZS30DjLzxxVjQEdlZbfqDu
         Nokfmk8bUeN4GSeywOGQAVvvVFYUngtuIq0sslygEcX3dEItMAacO6CkV01cz5pWlAIw
         FkgQ==
X-Gm-Message-State: AOAM530gQ1ZL4BejkXzvI0c1tKiZXxO5QBwwjFNQjkG0/FBIBdctTqbE
        1C6G5TA1nOGkob4JT6YgMBVtTA==
X-Google-Smtp-Source: ABdhPJxOc5ZJaeI1w2mIAzUuZnEBTDp3ooXloPRt6Qhgs0dpbE8UJXqVqnqD4yA+vs9abdhkERwmjw==
X-Received: by 2002:adf:aa93:: with SMTP id h19mr45560970wrc.293.1641384309497;
        Wed, 05 Jan 2022 04:05:09 -0800 (PST)
Received: from fiftytwodotfive.fritz.box (p200300e03f0d6c0075f7d8ec3244ded0.dip0.t-ipconnect.de. [2003:e0:3f0d:6c00:75f7:d8ec:3244:ded0])
        by smtp.gmail.com with ESMTPSA id k10sm22024310wrz.113.2022.01.05.04.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 04:05:09 -0800 (PST)
Message-ID: <6a517f87daa4c6d4fe93327fb0645d1698bc7556.camel@ionos.com>
Subject: Re: iblinkinfo for Python
From:   Benjamin Drung <benjamin.drung@ionos.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Date:   Wed, 05 Jan 2022 13:05:08 +0100
In-Reply-To: <YdWGZggTD38xgMh6@unreal>
References: <44396b05adcf8a414a9f4d6a843fce16670a83c1.camel@ionos.com>
         <YdWGZggTD38xgMh6@unreal>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am Mittwoch, dem 05.01.2022 um 13:52 +0200 schrieb Leon Romanovsky:
> On Wed, Jan 05, 2022 at 11:32:40AM +0100, Benjamin Drung wrote:
> > Hi,
> > 
> > we have an in-house Shell script that uses iblinkinfo to check if the
> > InfiniBand cabling is correct. This information can be derived from
> > the
> > node names that can be seen for the HCA port. I want to improve that
> > check and rewrite it in Python, but I failed to find an easy and
> > robust
> > way to retrieve the node names for a HCA port:
> > 
> > 1) Call "iblinkinfo --line" and parse the output. Parsing the output
> > could probably be done with a complex regular expression. This
> > solution
> > is too ugly IMO.
> > 
> > 2) Extend iblinkinfo to provide a JSON output. Then let the Python
> > script call "iblinkinfo --json" and simply use json.load for parsing.
> > This solution requires some C coding and probably a good json library
> > should be used to avoid generating bogus JSON.
> > 
> > 3) Use https://github.com/jgunthorpe/python-rdma but this library has
> > not been touched for five years and needs porting to Python 3. So
> > that
> > is probably a lot of work as well.
> > 
> > 4) Use pyverbs provided by rdma-core, but I found neither a single
> > API
> > call to query similar data to iblinkinfo, nor an example for that use
> > case.
> > 
> > What should I do?
> 
> Isn't this information available in sysfs?
> [leonro@mtl-leonro-l-vm ~]$ cat /sys/class/infiniband/ibp0s9/node_desc
> mtl-leonro-l-vm ibp0s9

The host names of the nodes connected to this port are required for
this check, not the host name of the host itself.

> Can you give an example?

```
$ sudo iblinkinfo -y 1 -C mlx5_0 -P 0 --line
0x04400C64D87A2543 "                  host1 mlx5_0"     13    [...]
0x04400C64D87A255c "                  host2 mlx5_0"     10    [...]
[...]
```

iblinkinfo would return the host names of all connected hosts (in this
example snippet "host1" and "host2"). In our inhouse case, we can
derive the topology from these host names.
> 

-- 
Benjamin Drung

Senior DevOps Engineer and Debian & Ubuntu Developer
Compute Platform Operations Cloud

IONOS SE | Revaler Str. 30 | 10245 Berlin | Deutschland
E-Mail: benjamin.drung@ionos.com | Web: www.ionos.de

Hauptsitz Montabaur, Amtsgericht Montabaur, HRB 24498

Vorstand: Hüseyin Dogan, Dr. Martin Endreß, Claudia Frese, Henning
Kettler, Arthur Mai, Britta Schmidt, Achim Weiß
Aufsichtsratsvorsitzender: Markus Kadelke


Member of United Internet

