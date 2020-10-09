Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2AD288D56
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 17:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389144AbgJIPwk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 11:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389135AbgJIPwk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Oct 2020 11:52:40 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFCCC0613D2
        for <linux-rdma@vger.kernel.org>; Fri,  9 Oct 2020 08:52:40 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id b10so2749561qvf.0
        for <linux-rdma@vger.kernel.org>; Fri, 09 Oct 2020 08:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kI6koypAHDjdUQJ/OUWn849189Y9AnAmd9opXVnOBNc=;
        b=dJzb439gwrTjwocUe/dUC6lMORvhZ9ORlQeHV4zn8FfZELb8Qghhx0AubovL9dTcbF
         VWcGbL/KykORKltezvJzwAtHhiCGQPbWU5HfeeCdsXnLlVslpQMycVDa1YnrW0QUOOpv
         tcvPSGw9Q6GbP9hvkn8oCer8zQaFWMnmMm05/UWQSgrORV/9qAQDim9czojAE+4Hlc7F
         szjeS1rR0xAhkV6KiVA3xyikE7fWUM4+9O+6nugDO3yv9/kAMmAnOWfSexIghdf14dhz
         rFVLwk8vJGF75o1e/muGw5e8YMXJQDtvkSRGMl3c0cBtgqkm7kF0sEN6JrLmCFhqMjI+
         mYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kI6koypAHDjdUQJ/OUWn849189Y9AnAmd9opXVnOBNc=;
        b=T6SDXcR1Dq1SdJn43+ACLYvYw1p9XsPW888FEqF8EluyKQmQn3SG332as9yxwHQFMJ
         cT1gDAzC/4FtnZ8Mo6YuUNrQ0kh6NPQlNVgscp9A2ZCulFqZUSKiiGnDHrZQaeURY0J5
         yENlig5QJq9kz7SwtuAyN+zGO1oJSwhBvnRaCRlSnH4dMFm4cUbacqm80D91JiZIsWR0
         u3QFPDe2lK9CqPUWtN062lCc4GiCliXCH4CPGSZ08dYf9/yQRO8qNGh/DjZ1JCNnn8t8
         HP4ACCAAJQAhEqiSU4xPLRYsdixeMGrMLk0fJ+duCKfhm7+QICuLqMdyah0dBIgOnoCJ
         +iaA==
X-Gm-Message-State: AOAM532MjKYbNwMLi8PSQ9Z+Mz/frlUTs5xcmKEPDt+TKw0Uzy9BDWmD
        vbBZPO6AUNT3DmBFU0e2L14=
X-Google-Smtp-Source: ABdhPJwz/zaI7eihCwPYLdi49dUXU01UwZRuVuz9KPzBTc3OtILBDUwzFR6NfcuU5jwOISby8O3dSA==
X-Received: by 2002:a05:6214:1873:: with SMTP id eh19mr13830426qvb.16.1602258759580;
        Fri, 09 Oct 2020 08:52:39 -0700 (PDT)
Received: from anon-dhcp-152.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t1sm1743519qkh.19.2020.10.09.08.52.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2020 08:52:38 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <20201009153406.GA5177@ziepe.ca>
Date:   Fri, 9 Oct 2020 11:52:37 -0400
Cc:     Leon Romanovsky <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <06F8D44C-BB1E-4D72-AFCE-FFD52E20C9CF@gmail.com>
References: <20201008103641.GM13580@unreal>
 <aec6906d-7be5-b489-c7dc-0254c4538723@oracle.com>
 <20201008160814.GF5177@ziepe.ca>
 <727de097-4338-c1d8-73a0-1fce0854f8af@oracle.com>
 <20201009143940.GT5177@ziepe.ca>
 <0E82FB51-244C-4134-8F74-8C365259DCD5@gmail.com>
 <20201009145706.GU5177@ziepe.ca>
 <EC7EE276-3529-4374-9F90-F061AAC3B952@gmail.com>
 <20201009150758.GV5177@ziepe.ca>
 <7EC25CA9-27B5-4900-B49C-43D29ED06EB6@gmail.com>
 <20201009153406.GA5177@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Ka-Cheong Poon <ka-cheong.poon@oracle.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Oct 9, 2020, at 11:34 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> On Fri, Oct 09, 2020 at 11:27:44AM -0400, Chuck Lever wrote:
> 
>> Therefore I think the approach is going to be "one RDS listener per
>> net namespace". The problem Ka-Cheong is trying to address is how to
>> manage the destruction of a listener-namespace pair. The extra
>> reference count on the cm_id is pinning the namespace so it cannot
>> be destroyed.
> 
> I really don't think this idea of just loading a kernel module and it
> immediately creates a network visibile listening socket in every
> namespace is very good.
> 
>> Understood, but it doesn't seem like there is enough useful overlap
>> between the NFS and RDS usage scenarios. With NFS, I would expect
>> an explicit listener shutdown from userland prior to namespace
>> destruction.
> 
> Yes, because namespaces are fundamentally supposed to be anchored in
> the processes inside the namespace.

Aye, the container model.


> Having the kernel jump in and start opening holes as soon as a
> namespace is created is just wrong.
> 
> At a bare minimum the listener should not exist until something in the
> namespace is willing to work with RDS.

I was thinking that too, but I'm not sure if that change would have
ramifications to existing RDS applications. There's quite a bit of
legacy to deal with.

An alternative would be to add a user daemon to RDS to manage the
listener lifecycle, rather than having the endpoint created by
module load. That might help the listener-namespace destruction
issue, and should be entirely application-transparent.


--
Chuck Lever
chucklever@gmail.com



