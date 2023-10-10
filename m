Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223CE7BF29D
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Oct 2023 07:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442198AbjJJF7Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Oct 2023 01:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442179AbjJJF7O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Oct 2023 01:59:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27EFC4;
        Mon,  9 Oct 2023 22:59:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCE0C433C8;
        Tue, 10 Oct 2023 05:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696917551;
        bh=S2Vq73dxgI8Hax8ZDzPktuJJ9WTcUpUL+/KM/V79r44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kg+lbBI2WFWTfw1g2nP0OCMspsLaEmhAGl8iOsaj2cy/oJfzG7zS6LdyTH+rgqFJW
         sxCvDQ6Jwy3j0Ae58keCkT9pNIKZqzy2q0BM7QcmVrgaG+duK+v7nL5BaVefquSsO4
         loMdrlwL5KeekjdN5/LA2S/AHzLoLV9Rn2EfXKfI=
Date:   Tue, 10 Oct 2023 07:59:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
        nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-leds@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 6/7] fs/sysfs/group: make attribute_group pointers const
Message-ID: <2023101025-yogurt-masses-47da@gregkh>
References: <20231009165741.746184-1-max.kellermann@ionos.com>
 <20231009165741.746184-6-max.kellermann@ionos.com>
 <264fa39d-aed6-4a54-a085-107997078f8d@roeck-us.net>
 <CAKPOu+8k2x1CucWSzoouts0AfMJk+srJXWWf3iWVOeY+fWkOpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+8k2x1CucWSzoouts0AfMJk+srJXWWf3iWVOeY+fWkOpQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 09, 2023 at 10:05:55PM +0200, Max Kellermann wrote:
> On Mon, Oct 9, 2023 at 7:24 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > Also, I don't know why checkpatch is happy with all the
> >
> >         const struct attribute_group *const*groups;
> >
> > instead of
> >
> >         const struct attribute_group *const *groups;
> 
> I found out that checkpatch has no check for this at all; it does
> complain about such lines, but only for local variables. But that
> warning is actually a bug, because this is a check for unary
> operators: it thinks the asterisk is a dereference operator, not a
> pointer declaration, and complains that the unary operator must be
> preceded by a space. Thus warnings on local variable are only correct
> by coincidence, not by design.
> 
> Inside structs or parameters (where my coding style violations can be
> found), it's a different context and thus checkpatch doesn't apply the
> rules for unary operators.

Ok, checkpatch support isn't always required, we can notice that changes
like this obviously are not sane and shouldn't be allowed just by
reading them :)

thanks,

greg k-h
