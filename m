Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1525236B04C
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Apr 2021 11:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhDZJNe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Apr 2021 05:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbhDZJNe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Apr 2021 05:13:34 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D646C061574
        for <linux-rdma@vger.kernel.org>; Mon, 26 Apr 2021 02:12:53 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i21-20020a05600c3555b029012eae2af5d4so4765245wmq.4
        for <linux-rdma@vger.kernel.org>; Mon, 26 Apr 2021 02:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=35eSVZFFpgt24b284ta68xZkjVEc5DHeIHOxrBV2sa8=;
        b=afamIN5+IzvT7nZLV7eFBLFFxabmJsbslqgRZSabWgdnpo0AkKBwtsepBhBQ8JV+Wn
         KNT1phdBreDOnpD/b6djMTr737g0E6gz5aGSiJxyHQOzVtqCuPzSZdVKq5Kg5I+lQLfJ
         URFFEPfhsEFere1lg2HrcomX5ZDfw0S3b897eEaERjdULMqiVGxAsF8wud4uifVLu4jL
         7id5FvTVMOWz2ovg4+V5w+v6umHhQzQXcwVwG+6RNHL4xAdUm5aKuOzHYIhMuutZdKLP
         1SO35Tz3pjP8AkzRsaaQAdWA4iXLJ/bLAHe0Hilagc4w/r55IfO8tdJHHEf0TN0ziQCQ
         s1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=35eSVZFFpgt24b284ta68xZkjVEc5DHeIHOxrBV2sa8=;
        b=O7x5xI93qHg+HL0IiekAWofE2JA5RNiyERSQzlQZWa4CSAL4WOgmYmMHL0J9UEy9po
         errOVX1mmeSzavTZyL5heaN7BsijyltF1fyQ9j/b6LHm53gTh4U7PETZiltC1WGmEdze
         BOOF2Iox3ITmyV7y9gZsHrun6Z2yRe5Hw4VmWvAWRiMQo8mAxZXTuB8lSJy/U389zmon
         9OVTbvCUZPIIp/4frcwXOIxZAexUNW1YaJsZztm+JAb1bjfNygAFC//T4ljH6aDWCyyQ
         4aDSwAZphOLMNlCfEnZLIkXzUHznDW3T5g1OBl+hPMMhsf994hRoo6EAvqySDQub6Vdh
         az/w==
X-Gm-Message-State: AOAM532zMx8IOnw8mMTxrjOvO5n9N8cuoKB75u+hPmMuRbln6W+05VvJ
        UgdVmKjCeLK859TaaqKd5T1mTe10Jla/W2Ax
X-Google-Smtp-Source: ABdhPJxLgEEvxAaDgKW9hwFS5u/LHdtWQwYqPrKQiRYX7MxCZ8uHj41Kv9FOrrlsBvg9tkeekxBd/w==
X-Received: by 2002:a1c:2c0a:: with SMTP id s10mr19712043wms.158.1619428372098;
        Mon, 26 Apr 2021 02:12:52 -0700 (PDT)
Received: from [192.168.3.162] (ip5b401b0e.dynamic.kabel-deutschland.de. [91.64.27.14])
        by smtp.gmail.com with ESMTPSA id q20sm47163981wmq.2.2021.04.26.02.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 02:12:51 -0700 (PDT)
Message-ID: <84ac2b08ac7440b12ddca7da7e722168cc15cd32.camel@ionos.com>
Subject: Re: rdma-core: Minimum supported Debian & Ubuntu releases
From:   Benjamin Drung <benjamin.drung@ionos.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 26 Apr 2021 11:12:50 +0200
In-Reply-To: <20210413164012.GJ227011@ziepe.ca>
References: <8d930476e5daf34147a178420596230dfecf2038.camel@cloud.ionos.com>
         <YHQttR48FsDJkuWd@unreal> <20210413164012.GJ227011@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am Dienstag, den 13.04.2021, 13:40 -0300 schrieb Jason Gunthorpe:
> On Mon, Apr 12, 2021 at 02:23:33PM +0300, Leon Romanovsky wrote:
> > On Mon, Apr 12, 2021 at 12:31:26PM +0200, Benjamin Drung wrote:
> > > Hi,
> > > 
> > > which Debian & Ubuntu releases should rdma-core support? Do we
> > > have a
> > > policy for that like all LTS versions?
> > 
> > I don't think that we have a policy for that.
> 
> I understand there are still active users on the prior LTS, so I
> would
> prefer to keep that working.

So to put numbers on it. rdma-core should support:

* Debian 9 (stretch) or newer
* Ubuntu 18.04 LTS (bionic) or newer

Debian 9 is currently oldstable and Ubuntu 18.04 LTS is the second
newest Ubuntu LTS version. Or do you refer to Debian 8 "jessie" (which
EOL last year) and Ubuntu 16.04 LTS (EOL around now)?

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

Diese E-Mail kann vertrauliche und/oder gesetzlich geschützte
Informationen enthalten. Wenn Sie nicht der bestimmungsgemäße Adressat
sind oder diese E-Mail irrtümlich erhalten haben, unterrichten Sie
bitte den Absender und vernichten Sie diese E-Mail. Anderen als dem
bestimmungsgemäßen Adressaten ist untersagt, diese E-Mail zu speichern,
weiterzuleiten oder ihren Inhalt auf welche Weise auch immer zu
verwenden.

This e-mail may contain confidential and/or privileged information. If
you are not the intended recipient of this e-mail, you are hereby
notified that saving, distribution or use of the content of this e-mail
in any way is prohibited. If you have received this e-mail in error,
please notify the sender and delete the e-mail.


