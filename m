Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE0FDB67DA
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Sep 2019 18:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387560AbfIRQRf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Sep 2019 12:17:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31141 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387555AbfIRQRf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Sep 2019 12:17:35 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 648792AFF40
        for <linux-rdma@vger.kernel.org>; Wed, 18 Sep 2019 16:17:35 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id 59so616871qtc.5
        for <linux-rdma@vger.kernel.org>; Wed, 18 Sep 2019 09:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rAFLqPnDXXL6syhfzi21csI37vHpTVq828Y+cIHnv5M=;
        b=BKr1b4ioeek35ZpCiZoQXUcQA4bbMqDzaMW/QGjiS5Zd/iXF1apgJ/sOERuKxOABPx
         ub0epLXPt0sCOL/BeuqLTR0DnpUxjS9FsvfE7QZQByetb+b1uaANM8naItLraaNUd47s
         tPvs9GDKq0qicxSEvnztYSTmwWwWaWJKA3qjro/wBygS3a2gEpVpWUMpBtyf2N56buWC
         xwSbzogrnw8SUPbAnPJhGGaI3tbllg7oksiQvAghmbtXLAUh/WBS2493s7tJEtY6Qw7G
         6Rv8oXs69ci9Sdb7UbWf3LZBaoCQQnCFW7B1UHUTJFZjL8CZ7OYJagskjo7rn0KlGiKq
         3yKw==
X-Gm-Message-State: APjAAAV2Pg0cC9vqvSRuONvPKOSwPBJHr43qEHAgCl5W68+Y2MFqfLEk
        ZiAAFqVmkVdAhaJ2lliJN5aQD9IDWfQJ2HFVB4//Zje7LcOi6tYcTQnAdj/GcpPOuVyv5PqQbJu
        YFMMrn/DL9tU6BiKpL9GMug==
X-Received: by 2002:a37:9b89:: with SMTP id d131mr4934618qke.176.1568823454490;
        Wed, 18 Sep 2019 09:17:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxQjxBZGN+z5yJeJwtu3woAQuhkbzYZoLfgFgrq5cUQbwK9FY+pDurAS6QIM1PWD1qWMRutYg==
X-Received: by 2002:a37:9b89:: with SMTP id d131mr4934583qke.176.1568823454181;
        Wed, 18 Sep 2019 09:17:34 -0700 (PDT)
Received: from rhel7lobe ([2600:6c64:4e80:f1:aa45:cafe:5682:368f])
        by smtp.gmail.com with ESMTPSA id k17sm3795911qtk.7.2019.09.18.09.17.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 09:17:33 -0700 (PDT)
Message-ID: <ae55e946c8d355f5c1e2e4f4575c76b44cd8d14f.camel@redhat.com>
Subject: Re: 5.3-rc8 tests all pass with RDMA/SRP testing
From:   Laurence Oberman <loberman@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "Dutile, Don" <ddutile@redhat.com>
Cc:     Rupesh Girase <rgirase@redhat.com>
Date:   Wed, 18 Sep 2019 12:17:32 -0400
In-Reply-To: <c9e449ab-23d6-0036-7056-8c49e4efdf0b@acm.org>
References: <3d41038fc1e720937606589d1ba91591486dd548.camel@redhat.com>
         <c9e449ab-23d6-0036-7056-8c49e4efdf0b@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 2019-09-17 at 10:59 -0700, Bart Van Assche wrote:
> On 9/12/19 12:48 PM, Laurence Oberman wrote:
> > My usual 3 month SRP test results show all is still well with SRP
> > client drivers and multipath.
> > I am still using 4.16 for the ib_srpt on the target server.
> > 
> > 5.3-rc8 ib_srp CX4 100Gbit EDR tests
> > direct and unbuffered, large and small I/O sizes
> > port recovery with fault injection
> > 
> > One small observation was that after fault injection it seemed to
> > take
> > longer to log back in, in that I needed to extend my sleep in the
> > injection script to avoid some multipaths lose all paths.
> > 
> > I was sleeping 30s between resets prior to this and I would log
> > back in
> > quick enough to not lose all paths.
> > My sleep is now 60s
> > 
> > #on ibclient server in /sys/class/srp_remote_ports, using echo 1 >
> > delete for the particular port will simulate a port reset.
> > 
> > #/sys/class/srp_remote_ports
> > #[root@ibclient srp_remote_ports]# ls
> > #port-1:1  port-2:1
> > for d in /sys/class/srp_remote_ports/*
> > do
> > 	echo 1 > $d/delete
> > sleep 60
> > done
> 
> Hi Laurence,
> 
> This is weird. Has this behavior change been observed once or has it 
> been observed multiple times? I'm asking because in my tests I
> noticed 
> that there can be variation between tests depending on how much time
> the 
> SCSI error handler spends in its error recovery strategy.
> 
> Thanks,
> 
> Bart.

Hi Bart, 
Well the tests have been at 30s for quite a while.
The 30s used to be long enough to get by in my tests.
I would have to go back a bit to see when it started seeing these
longer delays but I fully expect it to be related to EH changes to be
honest.

When I started getting hard errors I realized I was taking the second
port out before the first had recovered now.

Just let you know in case you have to change your blktests etc.

Thanks 
Laurence




