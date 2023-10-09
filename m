Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDA17BE7CB
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Oct 2023 19:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377648AbjJIRYx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Oct 2023 13:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377258AbjJIRYw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Oct 2023 13:24:52 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C569A3;
        Mon,  9 Oct 2023 10:24:51 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-578d0d94986so3492567a12.2;
        Mon, 09 Oct 2023 10:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696872290; x=1697477090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hzAdnPv6S7wemZW2LOvDdjej33oUOA4jt9qFcygegX8=;
        b=VcdmRB5Jyqw8aqvnps3ZcNESprEZdvjdfZIHohOck7OQ+ebTQDRRCAy5hDXxTGcBdW
         JEWThpfElMZZN6U7JsjnB5HH54J80NACyeKE3UbKbZCn6+bgBpt9Aa1leQHU85YufaMy
         iQbTWQUTq0Vw6PZIvJa8rUjjqanvgZw0ric83OoIZNRhValzcMsodZT/47Hl3oaBzBMQ
         lkWwnvITABSzqb1v73HekQEZSg75DYG95nUNBS76vzSMiaO355GiFoXRORwaIzvHlSY/
         lezXmO1mxVPjyoBpb0fCiRcp1Wj/dvqoRpvGHK2Ym2SJmFrC5rORF6cLNIyUSGCYQpUH
         sQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696872290; x=1697477090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzAdnPv6S7wemZW2LOvDdjej33oUOA4jt9qFcygegX8=;
        b=E75aMKFKTiQieeU28mkZ0AbzQI0IkhDi/5k6iSZUO4uEQRPyndpw/RP/bMRy0LatgT
         WNjaqRl9zR00QX9R+2jNiyfnX/le48V2g+BqCl82r4X7Imz28nfLbdxAWXcLZEWB2Sie
         mgHCOp5O5xt3SzjydAT2LU0bEv7O9xG7HoTZIIu4MQvm+PvS1SDmVpqPVTIGwgQBQLxx
         bZwHFAQi1F9kX1yw7i//D3ZrID6KW4ovplI0wQHJkUw5DldcGPS+WXy/yeKc77nhD7T1
         fj463MYoENIbQb8wN/hHa5UfvECy2Js/lAGt+dVVqNynDrGbDnfSEWJz5KRs0y5wEmg1
         P4+A==
X-Gm-Message-State: AOJu0YwljsRwStMLikM9hRsaj+osT/BPLN2bOmDZ3tRZgPgxdpg2A6mM
        3vXfkBbcyOkgLonNJwuH7Qw=
X-Google-Smtp-Source: AGHT+IH+tyPqS70qDikWknMDjzYLaNh8XUrbid6v4dI3mkvPqY7I02GkSEKBPm73V9X3Q4ayZd0Azg==
X-Received: by 2002:a05:6a20:8e05:b0:162:4f45:b415 with SMTP id y5-20020a056a208e0500b001624f45b415mr20823608pzj.51.1696872290343;
        Mon, 09 Oct 2023 10:24:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m24-20020a17090a7f9800b0027b168cb011sm8557487pjl.56.2023.10.09.10.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 10:24:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 9 Oct 2023 10:24:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <264fa39d-aed6-4a54-a085-107997078f8d@roeck-us.net>
References: <20231009165741.746184-1-max.kellermann@ionos.com>
 <20231009165741.746184-6-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009165741.746184-6-max.kellermann@ionos.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 09, 2023 at 06:57:39PM +0200, Max Kellermann wrote:
> This allows passing arrays of const pointers.  The goal is to make
> lots of global variables "const" to allow them to live in the
> ".rodata" section.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

In my opinion this touches way too many subsystems in a single patch.
If someting is wrong with just one of the changes, it will be all but
impossible to revert the whole thing.

Also, I don't know why checkpatch is happy with all the

	const struct attribute_group *const*groups;

instead of

	const struct attribute_group *const *groups;

but I still don't like it.

Guenter
