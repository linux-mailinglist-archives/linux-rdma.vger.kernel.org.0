Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700467BE72B
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Oct 2023 18:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377865AbjJIQ6P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Oct 2023 12:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377860AbjJIQ6M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Oct 2023 12:58:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ADA10D
        for <linux-rdma@vger.kernel.org>; Mon,  9 Oct 2023 09:58:05 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32167a4adaaso4332332f8f.1
        for <linux-rdma@vger.kernel.org>; Mon, 09 Oct 2023 09:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1696870684; x=1697475484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fGEDKmvpwz1xyuvst+pSH7DqilbUjJUGxnttYPFgHE=;
        b=WKd5Spu6K0x9fmdgnJFqll07QmERoj6j3OEVVu1ZSaS6hZfEZS9cCU2l982Gihauu9
         lbbbIvRcvPScIoJl4tM0KS9KbAqKyNmcEYiJHasTeD5X0rJMNv+ByVyuqMrvfip3P3Zi
         cM5X2NWxq3blGIa2gaC6XMuWaOObPLZHs6SNKiRYcm+23ZW37CjGxPWG7uJqKVBOELKz
         8uHaXWO+1xMO71aFG94Edo1nX4h5FM1SQlFoLDUa5m6AWJ8ouFz49Odp4JFKHLYKAPl7
         3aGvqF6I5VFvC5Fjo0VvBq2j+ppp0AtUPAMgGkxFOGrNNXYIDUNIBUh9T8X7fqnIMWUJ
         g8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696870684; x=1697475484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fGEDKmvpwz1xyuvst+pSH7DqilbUjJUGxnttYPFgHE=;
        b=ZjAHFOoF5Pw5aRU/hCfjBrl8hFbEoZYULrK5fdK8yzdNjN22czEfh5JFq3i4HMyafv
         7XYjBGPnaScRxMRExdAe31xHAoQ6iebko4jatq9W/kzdkkfZp5XhwQcNYfWVZs5jOuYW
         mZTPjLhIF3qbxKVhpORhFyGQ+sl8uxVOKQGZ+Y2GBt0mg1G0oSJGikqxV7GGD6i312H9
         Y3SVp7k2h9aJq2Je5qjrvgT6elf7y+KAXy8M2xoRgCegrFEzVLWWdqjHGYidsuAm2X+/
         Yp3RHD6wF4rmwSg/E5ORSdSWslLuLXuWJ7bcHlsjnRVmdVmJSjRegn26GpCr0lt4IYb7
         kT6w==
X-Gm-Message-State: AOJu0Yy60/GUpLfG4AxAROhvXtyxgPS8amf805m8uJR1cp4+gZ60C+Jm
        KK8EH63kN2IU9dd1Qwu2UAJj/Q==
X-Google-Smtp-Source: AGHT+IFRpoAWSHFTcdQpA1RgiCYhw3qHBAvdadv7mPHxoliJevUhbsUg50CoelGYv/9WDFppecI2Rw==
X-Received: by 2002:a5d:58c2:0:b0:319:7a9f:c63 with SMTP id o2-20020a5d58c2000000b003197a9f0c63mr14278217wrf.50.1696870683538;
        Mon, 09 Oct 2023 09:58:03 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f49a600529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f49:a600:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id d9-20020adff2c9000000b00324887a13f7sm10199828wrp.0.2023.10.09.09.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:58:03 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
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
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
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
Subject: [PATCH 6/7] fs/sysfs/group: make attribute_group pointers const
Date:   Mon,  9 Oct 2023 18:57:39 +0200
Message-Id: <20231009165741.746184-6-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009165741.746184-1-max.kellermann@ionos.com>
References: <20231009165741.746184-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This allows passing arrays of const pointers.  The goal is to make
lots of global variables "const" to allow them to live in the
".rodata" section.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 block/genhd.c                       |  2 +-
 drivers/base/base.h                 |  4 ++--
 drivers/base/bus.c                  |  6 +++---
 drivers/base/cacheinfo.c            |  4 ++--
 drivers/base/core.c                 | 14 +++++++-------
 drivers/base/cpu.c                  |  4 ++--
 drivers/base/driver.c               |  4 ++--
 drivers/edac/edac_mc.c              |  2 +-
 drivers/edac/edac_mc.h              |  2 +-
 drivers/edac/edac_mc_sysfs.c        |  2 +-
 drivers/edac/edac_module.h          |  2 +-
 drivers/hwmon/hwmon.c               | 12 ++++++------
 drivers/hwmon/pmbus/pmbus.h         |  2 +-
 drivers/infiniband/core/core_priv.h |  4 ++--
 drivers/infiniband/core/sysfs.c     |  4 ++--
 drivers/infiniband/ulp/srp/ib_srp.c |  2 +-
 drivers/iommu/iommu-sysfs.c         |  2 +-
 drivers/nvdimm/dimm_devs.c          |  2 +-
 drivers/nvme/host/nvme.h            |  2 +-
 drivers/rtc/rtc-core.h              |  4 ++--
 drivers/rtc/sysfs.c                 |  6 +++---
 drivers/tty/tty_io.c                |  2 +-
 drivers/tty/tty_port.c              |  4 ++--
 fs/sysfs/group.c                    | 10 +++++-----
 include/linux/blkdev.h              |  2 +-
 include/linux/coresight.h           |  2 +-
 include/linux/cpu.h                 |  2 +-
 include/linux/device.h              | 16 ++++++++--------
 include/linux/device/bus.h          |  6 +++---
 include/linux/device/class.h        |  4 ++--
 include/linux/device/driver.h       |  4 ++--
 include/linux/hwmon.h               |  8 ++++----
 include/linux/iommu.h               |  4 ++--
 include/linux/kobject.h             |  2 +-
 include/linux/leds.h                |  4 ++--
 include/linux/libnvdimm.h           |  8 ++++----
 include/linux/miscdevice.h          |  2 +-
 include/linux/pci.h                 |  4 ++--
 include/linux/perf_event.h          |  2 +-
 include/linux/power_supply.h        |  2 +-
 include/linux/rtc.h                 |  4 ++--
 include/linux/sysfs.h               | 16 ++++++++--------
 include/linux/tty_driver.h          |  2 +-
 include/linux/tty_port.h            |  4 ++--
 include/linux/usb.h                 |  4 ++--
 include/linux/w1.h                  |  2 +-
 include/linux/watchdog.h            |  2 +-
 include/rdma/ib_verbs.h             |  2 +-
 include/scsi/scsi_host.h            |  4 ++--
 49 files changed, 107 insertions(+), 107 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index cc32a0c704eb..d82560a79b04 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -394,7 +394,7 @@ int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
  * with the kernel.
  */
 int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
-				 const struct attribute_group **groups)
+				 const struct attribute_group *const*groups)
 
 {
 	struct device *ddev = disk_to_dev(disk);
diff --git a/drivers/base/base.h b/drivers/base/base.h
index eb4c0ace9242..a2c011d9a5ca 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -175,8 +175,8 @@ static inline void dev_sync_state(struct device *dev)
 		dev->driver->sync_state(dev);
 }
 
-int driver_add_groups(struct device_driver *drv, const struct attribute_group **groups);
-void driver_remove_groups(struct device_driver *drv, const struct attribute_group **groups);
+int driver_add_groups(struct device_driver *drv, const struct attribute_group *const*groups);
+void driver_remove_groups(struct device_driver *drv, const struct attribute_group *const*groups);
 void device_driver_detach(struct device *dev);
 
 int devres_release_all(struct device *dev);
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 84a21084d67d..d0331d07fffe 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -1195,7 +1195,7 @@ static void system_root_device_release(struct device *dev)
 }
 
 static int subsys_register(struct bus_type *subsys,
-			   const struct attribute_group **groups,
+			   const struct attribute_group *const*groups,
 			   struct kobject *parent_of_root)
 {
 	struct subsys_private *sp;
@@ -1265,7 +1265,7 @@ static int subsys_register(struct bus_type *subsys,
  * /sys/devices/system/<name>.
  */
 int subsys_system_register(struct bus_type *subsys,
-			   const struct attribute_group **groups)
+			   const struct attribute_group *const*groups)
 {
 	return subsys_register(subsys, groups, &system_kset->kobj);
 }
@@ -1283,7 +1283,7 @@ EXPORT_SYMBOL_GPL(subsys_system_register);
  * constructs which need sysfs interface.
  */
 int subsys_virtual_register(struct bus_type *subsys,
-			    const struct attribute_group **groups)
+			    const struct attribute_group *const*groups)
 {
 	struct kobject *virtual_dir;
 
diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index cbae8be1fe52..b91c31c2a393 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -803,7 +803,7 @@ __weak cache_get_priv_group(struct cacheinfo *this_leaf)
 	return NULL;
 }
 
-static const struct attribute_group **
+static const struct attribute_group *const*
 cache_get_attribute_groups(struct cacheinfo *this_leaf)
 {
 	const struct attribute_group *priv_group =
@@ -868,7 +868,7 @@ static int cache_add_dev(unsigned int cpu)
 	int rc;
 	struct device *ci_dev, *parent;
 	struct cacheinfo *this_leaf;
-	const struct attribute_group **cache_groups;
+	const struct attribute_group *const*cache_groups;
 
 	rc = cpu_cache_sysfs_init(cpu);
 	if (unlikely(rc < 0))
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4d8b315c48a1..b0debc3b751d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2721,14 +2721,14 @@ static ssize_t removable_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(removable);
 
-int device_add_groups(struct device *dev, const struct attribute_group **groups)
+int device_add_groups(struct device *dev, const struct attribute_group *const*groups)
 {
 	return sysfs_create_groups(&dev->kobj, groups);
 }
 EXPORT_SYMBOL_GPL(device_add_groups);
 
 void device_remove_groups(struct device *dev,
-			  const struct attribute_group **groups)
+			  const struct attribute_group *const*groups)
 {
 	sysfs_remove_groups(&dev->kobj, groups);
 }
@@ -2736,7 +2736,7 @@ EXPORT_SYMBOL_GPL(device_remove_groups);
 
 union device_attr_group_devres {
 	const struct attribute_group *group;
-	const struct attribute_group **groups;
+	const struct attribute_group *const*groups;
 };
 
 static void devm_attr_group_remove(struct device *dev, void *res)
@@ -2751,7 +2751,7 @@ static void devm_attr_group_remove(struct device *dev, void *res)
 static void devm_attr_groups_remove(struct device *dev, void *res)
 {
 	union device_attr_group_devres *devres = res;
-	const struct attribute_group **groups = devres->groups;
+	const struct attribute_group *const*groups = devres->groups;
 
 	dev_dbg(dev, "%s: removing groups %p\n", __func__, groups);
 	sysfs_remove_groups(&dev->kobj, groups);
@@ -2803,7 +2803,7 @@ EXPORT_SYMBOL_GPL(devm_device_add_group);
  * Returns 0 on success or error code from sysfs_create_group on failure.
  */
 int devm_device_add_groups(struct device *dev,
-			   const struct attribute_group **groups)
+			   const struct attribute_group *const*groups)
 {
 	union device_attr_group_devres *devres;
 	int error;
@@ -4281,7 +4281,7 @@ static void device_create_release(struct device *dev)
 static __printf(6, 0) struct device *
 device_create_groups_vargs(const struct class *class, struct device *parent,
 			   dev_t devt, void *drvdata,
-			   const struct attribute_group **groups,
+			   const struct attribute_group *const*groups,
 			   const char *fmt, va_list args)
 {
 	struct device *dev = NULL;
@@ -4381,7 +4381,7 @@ EXPORT_SYMBOL_GPL(device_create);
 struct device *device_create_with_groups(const struct class *class,
 					 struct device *parent, dev_t devt,
 					 void *drvdata,
-					 const struct attribute_group **groups,
+					 const struct attribute_group *const*groups,
 					 const char *fmt, ...)
 {
 	va_list vargs;
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 9ea22e165acd..bd51cb4e6e8c 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -434,7 +434,7 @@ static void device_create_release(struct device *dev)
 __printf(4, 0)
 static struct device *
 __cpu_device_create(struct device *parent, void *drvdata,
-		    const struct attribute_group **groups,
+		    const struct attribute_group *const*groups,
 		    const char *fmt, va_list args)
 {
 	struct device *dev = NULL;
@@ -467,7 +467,7 @@ __cpu_device_create(struct device *parent, void *drvdata,
 }
 
 struct device *cpu_device_create(struct device *parent, void *drvdata,
-				 const struct attribute_group **groups,
+				 const struct attribute_group *const*groups,
 				 const char *fmt, ...)
 {
 	va_list vargs;
diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index c8436c26ed6a..770bc8543f46 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -200,13 +200,13 @@ void driver_remove_file(struct device_driver *drv,
 EXPORT_SYMBOL_GPL(driver_remove_file);
 
 int driver_add_groups(struct device_driver *drv,
-		      const struct attribute_group **groups)
+		      const struct attribute_group *const*groups)
 {
 	return sysfs_create_groups(&drv->p->kobj, groups);
 }
 
 void driver_remove_groups(struct device_driver *drv,
-			  const struct attribute_group **groups)
+			  const struct attribute_group *const*groups)
 {
 	sysfs_remove_groups(&drv->p->kobj, groups);
 }
diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 6faeb2ab3960..766ba8ac4f47 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -598,7 +598,7 @@ EXPORT_SYMBOL_GPL(edac_get_owner);
 
 /* FIXME - should a warning be printed if no error detection? correction? */
 int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
-			       const struct attribute_group **groups)
+			       const struct attribute_group *const*groups)
 {
 	int ret = -EINVAL;
 	edac_dbg(0, "\n");
diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
index 881b00eadf7a..0ded68555d1c 100644
--- a/drivers/edac/edac_mc.h
+++ b/drivers/edac/edac_mc.h
@@ -146,7 +146,7 @@ extern const char *edac_get_owner(void);
  *	0 on Success, or an error code on failure
  */
 extern int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
-				      const struct attribute_group **groups);
+				      const struct attribute_group *const*groups);
 #define edac_mc_add_mc(mci)	edac_mc_add_mc_with_groups(mci, NULL)
 
 /**
diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 15f63452a9be..9ef2b139d8ae 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -931,7 +931,7 @@ static const struct device_type mci_attr_type = {
  *	!0	Failure
  */
 int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
-				 const struct attribute_group **groups)
+				 const struct attribute_group *const*groups)
 {
 	struct dimm_info *dimm;
 	int err;
diff --git a/drivers/edac/edac_module.h b/drivers/edac/edac_module.h
index 47593afdc234..734673339be5 100644
--- a/drivers/edac/edac_module.h
+++ b/drivers/edac/edac_module.h
@@ -27,7 +27,7 @@
 int edac_mc_sysfs_init(void);
 void edac_mc_sysfs_exit(void);
 extern int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
-					const struct attribute_group **groups);
+					const struct attribute_group *const*groups);
 extern void edac_remove_sysfs_mci_device(struct mem_ctl_info *mci);
 extern int edac_mc_get_log_ue(void);
 extern int edac_mc_get_log_ce(void);
diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index e50ab229b27d..d0305eaefa8b 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -37,7 +37,7 @@ struct hwmon_device {
 	const struct hwmon_chip_info *chip;
 	struct list_head tzdata;
 	struct attribute_group group;
-	const struct attribute_group **groups;
+	const struct attribute_group *const*groups;
 };
 
 #define to_hwmon_device(d) container_of(d, struct hwmon_device, dev)
@@ -756,7 +756,7 @@ __hwmon_create_attrs(const void *drvdata, const struct hwmon_chip_info *chip)
 static struct device *
 __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 			const struct hwmon_chip_info *chip,
-			const struct attribute_group **groups)
+			const struct attribute_group *const*groups)
 {
 	struct hwmon_device *hwdev;
 	const char *label;
@@ -884,7 +884,7 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 struct device *
 hwmon_device_register_with_groups(struct device *dev, const char *name,
 				  void *drvdata,
-				  const struct attribute_group **groups)
+				  const struct attribute_group *const*groups)
 {
 	if (!name)
 		return ERR_PTR(-EINVAL);
@@ -911,7 +911,7 @@ struct device *
 hwmon_device_register_with_info(struct device *dev, const char *name,
 				void *drvdata,
 				const struct hwmon_chip_info *chip,
-				const struct attribute_group **extra_groups)
+				const struct attribute_group *const*extra_groups)
 {
 	if (!dev || !name || !chip)
 		return ERR_PTR(-EINVAL);
@@ -1004,7 +1004,7 @@ static void devm_hwmon_release(struct device *dev, void *res)
 struct device *
 devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 				       void *drvdata,
-				       const struct attribute_group **groups)
+				       const struct attribute_group *const*groups)
 {
 	struct device **ptr, *hwdev;
 
@@ -1044,7 +1044,7 @@ struct device *
 devm_hwmon_device_register_with_info(struct device *dev, const char *name,
 				     void *drvdata,
 				     const struct hwmon_chip_info *chip,
-				     const struct attribute_group **extra_groups)
+				     const struct attribute_group *const*extra_groups)
 {
 	struct device **ptr, *hwdev;
 
diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index b0832a4c690d..bf039994b84f 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -456,7 +456,7 @@ struct pmbus_driver_info {
 	const struct regulator_desc *reg_desc;
 
 	/* custom attributes */
-	const struct attribute_group **groups;
+	const struct attribute_group *const*groups;
 };
 
 /* Regulator ops */
diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index f66f48d860ec..d4a444e52743 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -351,9 +351,9 @@ int ib_setup_device_attrs(struct ib_device *ibdev);
 int rdma_compatdev_set(u8 enable);
 
 int ib_port_register_client_groups(struct ib_device *ibdev, u32 port_num,
-				   const struct attribute_group **groups);
+				   const struct attribute_group *const*groups);
 void ib_port_unregister_client_groups(struct ib_device *ibdev, u32 port_num,
-				     const struct attribute_group **groups);
+				     const struct attribute_group *const*groups);
 
 int ib_device_set_netns_put(struct sk_buff *skb,
 			    struct ib_device *dev, u32 ns_fd);
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index ee59d7391568..fdd15d6a9c2f 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -1464,7 +1464,7 @@ int ib_setup_port_attrs(struct ib_core_device *coredev)
  * Do not use. Only for legacy sysfs compatibility.
  */
 int ib_port_register_client_groups(struct ib_device *ibdev, u32 port_num,
-				   const struct attribute_group **groups)
+				   const struct attribute_group *const*groups)
 {
 	return sysfs_create_groups(&ibdev->port_data[port_num].sysfs->kobj,
 				   groups);
@@ -1472,7 +1472,7 @@ int ib_port_register_client_groups(struct ib_device *ibdev, u32 port_num,
 EXPORT_SYMBOL(ib_port_register_client_groups);
 
 void ib_port_unregister_client_groups(struct ib_device *ibdev, u32 port_num,
-				      const struct attribute_group **groups)
+				      const struct attribute_group *const*groups)
 {
 	return sysfs_remove_groups(&ibdev->port_data[port_num].sysfs->kobj,
 				   groups);
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 2916e77f589b..0633b17fc082 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1021,7 +1021,7 @@ static int srp_init_cmd_priv(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
  */
 static void srp_del_scsi_host_attr(struct Scsi_Host *shost)
 {
-	const struct attribute_group **g;
+	const struct attribute_group *const*g;
 	struct attribute **attr;
 
 	for (g = shost->hostt->shost_groups; *g; ++g) {
diff --git a/drivers/iommu/iommu-sysfs.c b/drivers/iommu/iommu-sysfs.c
index cbe378c34ba3..ef92144b679f 100644
--- a/drivers/iommu/iommu-sysfs.c
+++ b/drivers/iommu/iommu-sysfs.c
@@ -53,7 +53,7 @@ postcore_initcall(iommu_dev_init);
  */
 int iommu_device_sysfs_add(struct iommu_device *iommu,
 			   struct device *parent,
-			   const struct attribute_group **groups,
+			   const struct attribute_group *const*groups,
 			   const char *fmt, ...)
 {
 	va_list vargs;
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 1273873582be..924dfc43f94c 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -580,7 +580,7 @@ bool is_nvdimm(const struct device *dev)
 static struct lock_class_key nvdimm_key;
 
 struct nvdimm *__nvdimm_create(struct nvdimm_bus *nvdimm_bus,
-		void *provider_data, const struct attribute_group **groups,
+		void *provider_data, const struct attribute_group *const*groups,
 		unsigned long flags, unsigned long cmd_mask, int num_flush,
 		struct resource *flush_wpq, const char *dimm_id,
 		const struct nvdimm_security_ops *sec_ops,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f35647c470af..90d0a1892b23 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -524,7 +524,7 @@ struct nvme_ctrl_ops {
 #define NVME_F_METADATA_SUPPORTED	(1 << 1)
 #define NVME_F_BLOCKING			(1 << 2)
 
-	const struct attribute_group **dev_attr_groups;
+	const struct attribute_group *const*dev_attr_groups;
 	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
diff --git a/drivers/rtc/rtc-core.h b/drivers/rtc/rtc-core.h
index 4b10a1b8f370..d21a967914dc 100644
--- a/drivers/rtc/rtc-core.h
+++ b/drivers/rtc/rtc-core.h
@@ -34,9 +34,9 @@ static inline void rtc_proc_del_device(struct rtc_device *rtc)
 #endif
 
 #ifdef CONFIG_RTC_INTF_SYSFS
-const struct attribute_group **rtc_get_dev_attribute_groups(void);
+const struct attribute_group *const*rtc_get_dev_attribute_groups(void);
 #else
-static inline const struct attribute_group **rtc_get_dev_attribute_groups(void)
+static inline const struct attribute_group *const*rtc_get_dev_attribute_groups(void)
 {
 	return NULL;
 }
diff --git a/drivers/rtc/sysfs.c b/drivers/rtc/sysfs.c
index 617933d52324..9c45c2557e28 100644
--- a/drivers/rtc/sysfs.c
+++ b/drivers/rtc/sysfs.c
@@ -308,7 +308,7 @@ static const struct attribute_group *rtc_attr_groups[] = {
 	NULL
 };
 
-const struct attribute_group **rtc_get_dev_attribute_groups(void)
+const struct attribute_group *const*rtc_get_dev_attribute_groups(void)
 {
 	return rtc_attr_groups;
 }
@@ -322,10 +322,10 @@ static size_t count_attribute_groups(const struct attribute_group *const*groups)
 	return count;
 }
 
-int rtc_add_groups(struct rtc_device *rtc, const struct attribute_group **grps)
+int rtc_add_groups(struct rtc_device *rtc, const struct attribute_group *const*grps)
 {
 	size_t old_cnt, add_cnt, new_cnt;
-	const struct attribute_group **groups, **old;
+	const struct attribute_group **groups, *const *old;
 
 	if (!grps)
 		return -EINVAL;
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 8a94e5a43c6d..2bbc193a6f47 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3212,7 +3212,7 @@ static void tty_device_create_release(struct device *dev)
 struct device *tty_register_device_attr(struct tty_driver *driver,
 				   unsigned index, struct device *device,
 				   void *drvdata,
-				   const struct attribute_group **attr_grp)
+				   const struct attribute_group *const*attr_grp)
 {
 	char name[64];
 	dev_t devt = MKDEV(driver->major, driver->minor_start) + index;
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 624d104bd145..f0f95e64ca64 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -158,7 +158,7 @@ EXPORT_SYMBOL_GPL(tty_port_register_device);
 struct device *tty_port_register_device_attr(struct tty_port *port,
 		struct tty_driver *driver, unsigned index,
 		struct device *device, void *drvdata,
-		const struct attribute_group **attr_grp)
+		const struct attribute_group *const*attr_grp)
 {
 	tty_port_link_device(port, driver, index);
 	return tty_register_device_attr(driver, index, device, drvdata,
@@ -181,7 +181,7 @@ EXPORT_SYMBOL_GPL(tty_port_register_device_attr);
 struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
 		struct tty_driver *driver, unsigned index,
 		struct device *device, void *drvdata,
-		const struct attribute_group **attr_grp)
+		const struct attribute_group *const*attr_grp)
 {
 	struct device *dev;
 
diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 138676463336..4e14df4da39d 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -180,7 +180,7 @@ int sysfs_create_group(struct kobject *kobj,
 EXPORT_SYMBOL_GPL(sysfs_create_group);
 
 static int internal_create_groups(struct kobject *kobj, int update,
-				  const struct attribute_group **groups)
+				  const struct attribute_group *const*groups)
 {
 	int error = 0;
 	int i;
@@ -213,7 +213,7 @@ static int internal_create_groups(struct kobject *kobj, int update,
  * Returns 0 on success or error code from sysfs_create_group on failure.
  */
 int sysfs_create_groups(struct kobject *kobj,
-			const struct attribute_group **groups)
+			const struct attribute_group *const*groups)
 {
 	return internal_create_groups(kobj, 0, groups);
 }
@@ -231,7 +231,7 @@ EXPORT_SYMBOL_GPL(sysfs_create_groups);
  * Returns 0 on success or error code from sysfs_update_group on failure.
  */
 int sysfs_update_groups(struct kobject *kobj,
-			const struct attribute_group **groups)
+			const struct attribute_group *const*groups)
 {
 	return internal_create_groups(kobj, 1, groups);
 }
@@ -306,7 +306,7 @@ EXPORT_SYMBOL_GPL(sysfs_remove_group);
  * If groups is not NULL, remove the specified groups from the kobject.
  */
 void sysfs_remove_groups(struct kobject *kobj,
-			 const struct attribute_group **groups)
+			 const struct attribute_group *const*groups)
 {
 	int i;
 
@@ -561,7 +561,7 @@ EXPORT_SYMBOL_GPL(sysfs_group_change_owner);
  * Returns 0 on success or error code on failure.
  */
 int sysfs_groups_change_owner(struct kobject *kobj,
-			      const struct attribute_group **groups,
+			      const struct attribute_group *const*groups,
 			      kuid_t kuid, kgid_t kgid)
 {
 	int error = 0, i;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index eef450f25982..7917b072775e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -729,7 +729,7 @@ static inline unsigned int blk_queue_depth(struct request_queue *q)
 	for (; _bio; _bio = _bio->bi_next)
 
 int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
-				 const struct attribute_group **groups);
+				 const struct attribute_group *const*groups);
 static inline int __must_check add_disk(struct gendisk *disk)
 {
 	return device_add_disk(NULL, disk, NULL);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index a269fffaf991..5dbe3883c02f 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -157,7 +157,7 @@ struct coresight_desc {
 	const struct coresight_ops *ops;
 	struct coresight_platform_data *pdata;
 	struct device *dev;
-	const struct attribute_group **groups;
+	const struct attribute_group *const*groups;
 	const char *name;
 	struct csdev_access access;
 };
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 0abd60a7987b..612955f50ed7 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -78,7 +78,7 @@ extern ssize_t cpu_show_gds(struct device *dev,
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,
-				 const struct attribute_group **groups,
+				 const struct attribute_group *const*groups,
 				 const char *fmt, ...);
 #ifdef CONFIG_HOTPLUG_CPU
 extern void unregister_cpu(struct cpu *cpu);
diff --git a/include/linux/device.h b/include/linux/device.h
index 56d93a1ffb7b..cf6ee60ecdb4 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -73,9 +73,9 @@ int subsys_interface_register(struct subsys_interface *sif);
 void subsys_interface_unregister(struct subsys_interface *sif);
 
 int subsys_system_register(struct bus_type *subsys,
-			   const struct attribute_group **groups);
+			   const struct attribute_group *const*groups);
 int subsys_virtual_register(struct bus_type *subsys,
-			    const struct attribute_group **groups);
+			    const struct attribute_group *const*groups);
 
 /*
  * The type of device, "struct device" is embedded in. A class
@@ -88,7 +88,7 @@ int subsys_virtual_register(struct bus_type *subsys,
  */
 struct device_type {
 	const char *name;
-	const struct attribute_group **groups;
+	const struct attribute_group *const*groups;
 	int (*uevent)(const struct device *dev, struct kobj_uevent_env *env);
 	char *(*devnode)(const struct device *dev, umode_t *mode,
 			 kuid_t *uid, kgid_t *gid);
@@ -782,7 +782,7 @@ struct device {
 	struct list_head	devres_head;
 
 	const struct class	*class;
-	const struct attribute_group **groups;	/* optional groups */
+	const struct attribute_group *const*groups;	/* optional groups */
 
 	void	(*release)(struct device *dev);
 	struct iommu_group	*iommu_group;
@@ -1177,14 +1177,14 @@ device_create(const struct class *cls, struct device *parent, dev_t devt,
 	      void *drvdata, const char *fmt, ...);
 __printf(6, 7) struct device *
 device_create_with_groups(const struct class *cls, struct device *parent, dev_t devt,
-			  void *drvdata, const struct attribute_group **groups,
+			  void *drvdata, const struct attribute_group *const*groups,
 			  const char *fmt, ...);
 void device_destroy(const struct class *cls, dev_t devt);
 
 int __must_check device_add_groups(struct device *dev,
-				   const struct attribute_group **groups);
+				   const struct attribute_group *const*groups);
 void device_remove_groups(struct device *dev,
-			  const struct attribute_group **groups);
+			  const struct attribute_group *const*groups);
 
 static inline int __must_check device_add_group(struct device *dev,
 					const struct attribute_group *grp)
@@ -1203,7 +1203,7 @@ static inline void device_remove_group(struct device *dev,
 }
 
 int __must_check devm_device_add_groups(struct device *dev,
-					const struct attribute_group **groups);
+					const struct attribute_group *const*groups);
 int __must_check devm_device_add_group(struct device *dev,
 				       const struct attribute_group *grp);
 
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index ae10c4322754..5867948b64ca 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -80,9 +80,9 @@ struct fwnode_handle;
 struct bus_type {
 	const char		*name;
 	const char		*dev_name;
-	const struct attribute_group **bus_groups;
-	const struct attribute_group **dev_groups;
-	const struct attribute_group **drv_groups;
+	const struct attribute_group *const*bus_groups;
+	const struct attribute_group *const*dev_groups;
+	const struct attribute_group *const*drv_groups;
 
 	int (*match)(struct device *dev, struct device_driver *drv);
 	int (*uevent)(const struct device *dev, struct kobj_uevent_env *env);
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index abf3d3bfb6fe..649020a67b87 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -52,8 +52,8 @@ struct fwnode_handle;
 struct class {
 	const char		*name;
 
-	const struct attribute_group	**class_groups;
-	const struct attribute_group	**dev_groups;
+	const struct attribute_group	*const*class_groups;
+	const struct attribute_group	*const*dev_groups;
 
 	int (*dev_uevent)(const struct device *dev, struct kobj_uevent_env *env);
 	char *(*devnode)(const struct device *dev, umode_t *mode);
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 7738f458995f..cb8171124bbf 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -112,8 +112,8 @@ struct device_driver {
 	void (*shutdown) (struct device *dev);
 	int (*suspend) (struct device *dev, pm_message_t state);
 	int (*resume) (struct device *dev);
-	const struct attribute_group **groups;
-	const struct attribute_group **dev_groups;
+	const struct attribute_group *const*groups;
+	const struct attribute_group *const*dev_groups;
 
 	const struct dev_pm_ops *pm;
 	void (*coredump) (struct device *dev);
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 8cd6a6b33593..fa3f3a6be5b5 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -453,16 +453,16 @@ struct device *hwmon_device_register(struct device *dev);
 struct device *
 hwmon_device_register_with_groups(struct device *dev, const char *name,
 				  void *drvdata,
-				  const struct attribute_group **groups);
+				  const struct attribute_group *const*groups);
 struct device *
 devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 				       void *drvdata,
-				       const struct attribute_group **groups);
+				       const struct attribute_group *const*groups);
 struct device *
 hwmon_device_register_with_info(struct device *dev,
 				const char *name, void *drvdata,
 				const struct hwmon_chip_info *info,
-				const struct attribute_group **extra_groups);
+				const struct attribute_group *const*extra_groups);
 struct device *
 hwmon_device_register_for_thermal(struct device *dev, const char *name,
 				  void *drvdata);
@@ -470,7 +470,7 @@ struct device *
 devm_hwmon_device_register_with_info(struct device *dev,
 				const char *name, void *drvdata,
 				const struct hwmon_chip_info *info,
-				const struct attribute_group **extra_groups);
+				const struct attribute_group *const*extra_groups);
 
 void hwmon_device_unregister(struct device *dev);
 void devm_hwmon_device_unregister(struct device *dev);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c50a769d569a..4169cfca3098 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -441,7 +441,7 @@ int iommu_device_register(struct iommu_device *iommu,
 void iommu_device_unregister(struct iommu_device *iommu);
 int  iommu_device_sysfs_add(struct iommu_device *iommu,
 			    struct device *parent,
-			    const struct attribute_group **groups,
+			    const struct attribute_group *const*groups,
 			    const char *fmt, ...) __printf(4, 5);
 void iommu_device_sysfs_remove(struct iommu_device *iommu);
 int  iommu_device_link(struct iommu_device   *iommu, struct device *link);
@@ -975,7 +975,7 @@ static inline void iommu_device_unregister(struct iommu_device *iommu)
 
 static inline int  iommu_device_sysfs_add(struct iommu_device *iommu,
 					  struct device *parent,
-					  const struct attribute_group **groups,
+					  const struct attribute_group *const*groups,
 					  const char *fmt, ...)
 {
 	return -ENODEV;
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index c30affcc43b4..989afe775880 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -116,7 +116,7 @@ char *kobject_get_path(const struct kobject *kobj, gfp_t flag);
 struct kobj_type {
 	void (*release)(struct kobject *kobj);
 	const struct sysfs_ops *sysfs_ops;
-	const struct attribute_group **default_groups;
+	const struct attribute_group *const*default_groups;
 	const struct kobj_ns_type_operations *(*child_ns_type)(const struct kobject *kobj);
 	const void *(*namespace)(const struct kobject *kobj);
 	void (*get_ownership)(const struct kobject *kobj, kuid_t *uid, kgid_t *gid);
diff --git a/include/linux/leds.h b/include/linux/leds.h
index aa16dc2a8230..6d84f5eb0883 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -166,7 +166,7 @@ struct led_classdev {
 	int (*pattern_clear)(struct led_classdev *led_cdev);
 
 	struct device		*dev;
-	const struct attribute_group	**groups;
+	const struct attribute_group	*const*groups;
 
 	struct list_head	 node;			/* LED Device list */
 	const char		*default_trigger;	/* Trigger to use */
@@ -484,7 +484,7 @@ struct led_trigger {
 	/* Link to next registered trigger */
 	struct list_head  next_trig;
 
-	const struct attribute_group **groups;
+	const struct attribute_group *const*groups;
 };
 
 /*
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index e772aae71843..7c629ee16215 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -82,7 +82,7 @@ typedef int (*ndctl_fn)(struct nvdimm_bus_descriptor *nd_desc,
 
 struct device_node;
 struct nvdimm_bus_descriptor {
-	const struct attribute_group **attr_groups;
+	const struct attribute_group *const*attr_groups;
 	unsigned long cmd_mask;
 	unsigned long dimm_family_mask;
 	unsigned long bus_family_mask;
@@ -126,7 +126,7 @@ struct nd_region_desc {
 	struct resource *res;
 	struct nd_mapping_desc *mapping;
 	u16 num_mappings;
-	const struct attribute_group **attr_groups;
+	const struct attribute_group *const*attr_groups;
 	struct nd_interleave_set *nd_set;
 	void *provider_data;
 	int num_lanes;
@@ -259,13 +259,13 @@ struct kobject *nvdimm_kobj(struct nvdimm *nvdimm);
 unsigned long nvdimm_cmd_mask(struct nvdimm *nvdimm);
 void *nvdimm_provider_data(struct nvdimm *nvdimm);
 struct nvdimm *__nvdimm_create(struct nvdimm_bus *nvdimm_bus,
-		void *provider_data, const struct attribute_group **groups,
+		void *provider_data, const struct attribute_group *const*groups,
 		unsigned long flags, unsigned long cmd_mask, int num_flush,
 		struct resource *flush_wpq, const char *dimm_id,
 		const struct nvdimm_security_ops *sec_ops,
 		const struct nvdimm_fw_ops *fw_ops);
 static inline struct nvdimm *nvdimm_create(struct nvdimm_bus *nvdimm_bus,
-		void *provider_data, const struct attribute_group **groups,
+		void *provider_data, const struct attribute_group *const*groups,
 		unsigned long flags, unsigned long cmd_mask, int num_flush,
 		struct resource *flush_wpq)
 {
diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
index c0fea6ca5076..32b0caf86cd1 100644
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -83,7 +83,7 @@ struct miscdevice  {
 	struct list_head list;
 	struct device *parent;
 	struct device *this_device;
-	const struct attribute_group **groups;
+	const struct attribute_group *const*groups;
 	const char *nodename;
 	umode_t mode;
 };
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8c7c2c3c6c65..57dbfd890ae7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -928,8 +928,8 @@ struct pci_driver {
 	int  (*sriov_set_msix_vec_count)(struct pci_dev *vf, int msix_vec_count); /* On PF */
 	u32  (*sriov_get_vf_total_msix)(struct pci_dev *pf);
 	const struct pci_error_handlers *err_handler;
-	const struct attribute_group **groups;
-	const struct attribute_group **dev_groups;
+	const struct attribute_group *const*groups;
+	const struct attribute_group *const*dev_groups;
 	struct device_driver	driver;
 	struct pci_dynids	dynids;
 	bool driver_managed_dma;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e85cd1c0eaf3..e9d68c611974 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -306,7 +306,7 @@ struct pmu {
 	struct device			*dev;
 	struct device			*parent;
 	const struct attribute_group	**attr_groups;
-	const struct attribute_group	**attr_update;
+	const struct attribute_group	*const*attr_update;
 	const char			*name;
 	int				type;
 
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index a427f13c757f..b7f592a20729 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -232,7 +232,7 @@ struct power_supply_config {
 	void *drv_data;
 
 	/* Device specific sysfs attributes */
-	const struct attribute_group **attr_grp;
+	const struct attribute_group *const*attr_grp;
 
 	char **supplied_to;
 	size_t num_supplicants;
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 4c0bcbeb1f00..f72e70186b2f 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -247,7 +247,7 @@ static inline int devm_rtc_nvmem_register(struct rtc_device *rtc,
 
 #ifdef CONFIG_RTC_INTF_SYSFS
 int rtc_add_group(struct rtc_device *rtc, const struct attribute_group *grp);
-int rtc_add_groups(struct rtc_device *rtc, const struct attribute_group **grps);
+int rtc_add_groups(struct rtc_device *rtc, const struct attribute_group *const*grps);
 #else
 static inline
 int rtc_add_group(struct rtc_device *rtc, const struct attribute_group *grp)
@@ -256,7 +256,7 @@ int rtc_add_group(struct rtc_device *rtc, const struct attribute_group *grp)
 }
 
 static inline
-int rtc_add_groups(struct rtc_device *rtc, const struct attribute_group **grps)
+int rtc_add_groups(struct rtc_device *rtc, const struct attribute_group *const*grps)
 {
 	return 0;
 }
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index fd3fe5c8c17f..2b97fb34204b 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -307,15 +307,15 @@ void sysfs_delete_link(struct kobject *dir, struct kobject *targ,
 int __must_check sysfs_create_group(struct kobject *kobj,
 				    const struct attribute_group *grp);
 int __must_check sysfs_create_groups(struct kobject *kobj,
-				     const struct attribute_group **groups);
+				     const struct attribute_group *const*groups);
 int __must_check sysfs_update_groups(struct kobject *kobj,
-				     const struct attribute_group **groups);
+				     const struct attribute_group *const*groups);
 int sysfs_update_group(struct kobject *kobj,
 		       const struct attribute_group *grp);
 void sysfs_remove_group(struct kobject *kobj,
 			const struct attribute_group *grp);
 void sysfs_remove_groups(struct kobject *kobj,
-			 const struct attribute_group **groups);
+			 const struct attribute_group *const*groups);
 int sysfs_add_file_to_group(struct kobject *kobj,
 			const struct attribute *attr, const char *group);
 void sysfs_remove_file_from_group(struct kobject *kobj,
@@ -348,7 +348,7 @@ int sysfs_change_owner(struct kobject *kobj, kuid_t kuid, kgid_t kgid);
 int sysfs_link_change_owner(struct kobject *kobj, struct kobject *targ,
 			    const char *name, kuid_t kuid, kgid_t kgid);
 int sysfs_groups_change_owner(struct kobject *kobj,
-			      const struct attribute_group **groups,
+			      const struct attribute_group *const*groups,
 			      kuid_t kuid, kgid_t kgid);
 int sysfs_group_change_owner(struct kobject *kobj,
 			     const struct attribute_group *groups, kuid_t kuid,
@@ -487,13 +487,13 @@ static inline int sysfs_create_group(struct kobject *kobj,
 }
 
 static inline int sysfs_create_groups(struct kobject *kobj,
-				      const struct attribute_group **groups)
+				      const struct attribute_group *const*groups)
 {
 	return 0;
 }
 
 static inline int sysfs_update_groups(struct kobject *kobj,
-				      const struct attribute_group **groups)
+				      const struct attribute_group *const*groups)
 {
 	return 0;
 }
@@ -510,7 +510,7 @@ static inline void sysfs_remove_group(struct kobject *kobj,
 }
 
 static inline void sysfs_remove_groups(struct kobject *kobj,
-				       const struct attribute_group **groups)
+				       const struct attribute_group *const*groups)
 {
 }
 
@@ -591,7 +591,7 @@ static inline int sysfs_change_owner(struct kobject *kobj, kuid_t kuid, kgid_t k
 }
 
 static inline int sysfs_groups_change_owner(struct kobject *kobj,
-			  const struct attribute_group **groups,
+			  const struct attribute_group *const*groups,
 			  kuid_t kuid, kgid_t kgid)
 {
 	return 0;
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 18beff0cec1a..3041bebb1051 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -571,7 +571,7 @@ struct device *tty_register_device(struct tty_driver *driver, unsigned index,
 		struct device *dev);
 struct device *tty_register_device_attr(struct tty_driver *driver,
 		unsigned index, struct device *device, void *drvdata,
-		const struct attribute_group **attr_grp);
+		const struct attribute_group *const*attr_grp);
 void tty_unregister_device(struct tty_driver *driver, unsigned index);
 
 #ifdef CONFIG_PROC_FS
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 6b367eb17979..811aa134150c 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -146,14 +146,14 @@ struct device *tty_port_register_device(struct tty_port *port,
 struct device *tty_port_register_device_attr(struct tty_port *port,
 		struct tty_driver *driver, unsigned index,
 		struct device *device, void *drvdata,
-		const struct attribute_group **attr_grp);
+		const struct attribute_group *const*attr_grp);
 struct device *tty_port_register_device_serdev(struct tty_port *port,
 		struct tty_driver *driver, unsigned index,
 		struct device *device);
 struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
 		struct tty_driver *driver, unsigned index,
 		struct device *device, void *drvdata,
-		const struct attribute_group **attr_grp);
+		const struct attribute_group *const*attr_grp);
 void tty_port_unregister_device(struct tty_port *port,
 		struct tty_driver *driver, unsigned index);
 int tty_port_alloc_xmit_buf(struct tty_port *port);
diff --git a/include/linux/usb.h b/include/linux/usb.h
index a21074861f91..321ded34928f 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1239,7 +1239,7 @@ struct usb_driver {
 	int (*post_reset)(struct usb_interface *intf);
 
 	const struct usb_device_id *id_table;
-	const struct attribute_group **dev_groups;
+	const struct attribute_group *const*dev_groups;
 
 	struct usb_dynids dynids;
 	struct usbdrv_wrap drvwrap;
@@ -1287,7 +1287,7 @@ struct usb_device_driver {
 
 	int (*suspend) (struct usb_device *udev, pm_message_t message);
 	int (*resume) (struct usb_device *udev, pm_message_t message);
-	const struct attribute_group **dev_groups;
+	const struct attribute_group *const*dev_groups;
 	struct usbdrv_wrap drvwrap;
 	const struct usb_device_id *id_table;
 	unsigned int supports_autosuspend:1;
diff --git a/include/linux/w1.h b/include/linux/w1.h
index 9a2a0ef39018..0c86a9ed7013 100644
--- a/include/linux/w1.h
+++ b/include/linux/w1.h
@@ -253,7 +253,7 @@ void w1_remove_master_device(struct w1_bus_master *master);
 struct w1_family_ops {
 	int  (*add_slave)(struct w1_slave *sl);
 	void (*remove_slave)(struct w1_slave *sl);
-	const struct attribute_group **groups;
+	const struct attribute_group *const*groups;
 	const struct hwmon_chip_info *chip_info;
 };
 
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 99660197a36c..1f4a0fae13ab 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -94,7 +94,7 @@ struct watchdog_ops {
 struct watchdog_device {
 	int id;
 	struct device *parent;
-	const struct attribute_group **groups;
+	const struct attribute_group *const*groups;
 	const struct watchdog_info *info;
 	const struct watchdog_ops *ops;
 	const struct watchdog_governor *gov;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 533ab92684d8..1a9511b99506 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2343,7 +2343,7 @@ struct ib_device_ops {
 	 * mechanism exists only for existing drivers.
 	 */
 	const struct attribute_group *device_group;
-	const struct attribute_group **port_groups;
+	const struct attribute_group *const*port_groups;
 
 	int (*post_send)(struct ib_qp *qp, const struct ib_send_wr *send_wr,
 			 const struct ib_send_wr **bad_send_wr);
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 4c2dc8150c6d..c9da91e96232 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -478,13 +478,13 @@ struct scsi_host_template {
 	/*
 	 * Pointer to the SCSI host sysfs attribute groups, NULL terminated.
 	 */
-	const struct attribute_group **shost_groups;
+	const struct attribute_group *const*shost_groups;
 
 	/*
 	 * Pointer to the SCSI device attribute groups for this host,
 	 * NULL terminated.
 	 */
-	const struct attribute_group **sdev_groups;
+	const struct attribute_group *const*sdev_groups;
 
 	/*
 	 * Vendor Identifier associated with the host
-- 
2.39.2

