Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E246E67A4FA
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jan 2023 22:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbjAXVa2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Jan 2023 16:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjAXVa1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Jan 2023 16:30:27 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE4F16ACB
        for <linux-rdma@vger.kernel.org>; Tue, 24 Jan 2023 13:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674595825; x=1706131825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rknlUi0ps5Ma9KVM47aCx69s2nZPi0dkaBPilmYcYPs=;
  b=YBByyltww2dvf4GE2pFxBRWKci12bfWr97BPes8+uIqt6t7tjJzVaCYt
   cnvya8uoBbdeOruqqnORF+ya+pk+3LNZra4CobHVK7yheO2+2fX9R5yBM
   x55k8GWbaEzG3IlzTu4HLtZvfgFUt+5yK6sqFiZ2ivdMbFJNYSo9Upfkc
   jFtS8rG7smkjGrlVL8mqrzG0R6Fy1Xhjly9BtydqZm0gKWgOD/nCUIo+U
   GiY3c0oI7NsZ2z1T0V7hLFJn1duycf7PLAmK0KyDWfEkSfJJSULC7oPDk
   xT4M2rwhdzQuNwz+U7ElOTVIe//GXFZACEpFK6ZPKRQNTY5qoKlkEO9an
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="314312681"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="314312681"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 13:30:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="612182894"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="612182894"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2023 13:30:22 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKQs1-0006nN-2g;
        Tue, 24 Jan 2023 21:30:21 +0000
Date:   Wed, 25 Jan 2023 05:29:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Guralnik <michaelgur@nvidia.com>, jgg@nvidia.com,
        leonro@nvidia.com, linux-rdma@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        maorg@nvidia.com, aharonl@nvidia.com,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH v4 rdma-next 4/6] RDMA/mlx5: Introduce mlx5r_cache_rb_key
Message-ID: <202301250543.S3rDnUPI-lkp@intel.com>
References: <20230115133454.29000-5-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230115133454.29000-5-michaelgur@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Michael,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v6.2-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Guralnik/RDMA-mlx5-Don-t-keep-umrable-page_shift-in-cache-entries/20230115-213631
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20230115133454.29000-5-michaelgur%40nvidia.com
patch subject: [PATCH v4 rdma-next 4/6] RDMA/mlx5: Introduce mlx5r_cache_rb_key
config: x86_64-randconfig-r021-20230123 (https://download.01.org/0day-ci/archive/20230125/202301250543.S3rDnUPI-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b248641a9895ca71c30d10b95b4be730fd65576a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Michael-Guralnik/RDMA-mlx5-Don-t-keep-umrable-page_shift-in-cache-entries/20230115-213631
        git checkout b248641a9895ca71c30d10b95b4be730fd65576a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/infiniband/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/infiniband/hw/mlx5/ah.c:33:
>> drivers/infiniband/hw/mlx5/mlx5_ib.h:1378:9: warning: incompatible pointer to integer conversion returning 'void *' from a function with result type 'int' [-Wint-conversion]
           return NULL;
                  ^~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
   #define NULL ((void *)0)
                ^~~~~~~~~~~
   1 warning generated.


vim +1378 drivers/infiniband/hw/mlx5/mlx5_ib.h

  1217	
  1218	int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context, unsigned long virt,
  1219				struct mlx5_db *db);
  1220	void mlx5_ib_db_unmap_user(struct mlx5_ib_ucontext *context, struct mlx5_db *db);
  1221	void __mlx5_ib_cq_clean(struct mlx5_ib_cq *cq, u32 qpn, struct mlx5_ib_srq *srq);
  1222	void mlx5_ib_cq_clean(struct mlx5_ib_cq *cq, u32 qpn, struct mlx5_ib_srq *srq);
  1223	void mlx5_ib_free_srq_wqe(struct mlx5_ib_srq *srq, int wqe_index);
  1224	int mlx5_ib_create_ah(struct ib_ah *ah, struct rdma_ah_init_attr *init_attr,
  1225			      struct ib_udata *udata);
  1226	int mlx5_ib_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr);
  1227	static inline int mlx5_ib_destroy_ah(struct ib_ah *ah, u32 flags)
  1228	{
  1229		return 0;
  1230	}
  1231	int mlx5_ib_create_srq(struct ib_srq *srq, struct ib_srq_init_attr *init_attr,
  1232			       struct ib_udata *udata);
  1233	int mlx5_ib_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
  1234			       enum ib_srq_attr_mask attr_mask, struct ib_udata *udata);
  1235	int mlx5_ib_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *srq_attr);
  1236	int mlx5_ib_destroy_srq(struct ib_srq *srq, struct ib_udata *udata);
  1237	int mlx5_ib_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
  1238				  const struct ib_recv_wr **bad_wr);
  1239	int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp);
  1240	void mlx5_ib_disable_lb(struct mlx5_ib_dev *dev, bool td, bool qp);
  1241	int mlx5_ib_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *init_attr,
  1242			      struct ib_udata *udata);
  1243	int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
  1244			      int attr_mask, struct ib_udata *udata);
  1245	int mlx5_ib_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr, int qp_attr_mask,
  1246			     struct ib_qp_init_attr *qp_init_attr);
  1247	int mlx5_ib_destroy_qp(struct ib_qp *qp, struct ib_udata *udata);
  1248	void mlx5_ib_drain_sq(struct ib_qp *qp);
  1249	void mlx5_ib_drain_rq(struct ib_qp *qp);
  1250	int mlx5_ib_read_wqe_sq(struct mlx5_ib_qp *qp, int wqe_index, void *buffer,
  1251				size_t buflen, size_t *bc);
  1252	int mlx5_ib_read_wqe_rq(struct mlx5_ib_qp *qp, int wqe_index, void *buffer,
  1253				size_t buflen, size_t *bc);
  1254	int mlx5_ib_read_wqe_srq(struct mlx5_ib_srq *srq, int wqe_index, void *buffer,
  1255				 size_t buflen, size_t *bc);
  1256	int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
  1257			      struct ib_udata *udata);
  1258	int mlx5_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
  1259	int mlx5_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
  1260	int mlx5_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
  1261	int mlx5_ib_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period);
  1262	int mlx5_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata);
  1263	struct ib_mr *mlx5_ib_get_dma_mr(struct ib_pd *pd, int acc);
  1264	struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
  1265					  u64 virt_addr, int access_flags,
  1266					  struct ib_udata *udata);
  1267	struct ib_mr *mlx5_ib_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
  1268						 u64 length, u64 virt_addr,
  1269						 int fd, int access_flags,
  1270						 struct ib_udata *udata);
  1271	int mlx5_ib_advise_mr(struct ib_pd *pd,
  1272			      enum ib_uverbs_advise_mr_advice advice,
  1273			      u32 flags,
  1274			      struct ib_sge *sg_list,
  1275			      u32 num_sge,
  1276			      struct uverbs_attr_bundle *attrs);
  1277	int mlx5_ib_alloc_mw(struct ib_mw *mw, struct ib_udata *udata);
  1278	int mlx5_ib_dealloc_mw(struct ib_mw *mw);
  1279	struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
  1280						     int access_flags);
  1281	void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *mr);
  1282	void mlx5_ib_free_odp_mr(struct mlx5_ib_mr *mr);
  1283	struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
  1284					    u64 length, u64 virt_addr, int access_flags,
  1285					    struct ib_pd *pd, struct ib_udata *udata);
  1286	int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
  1287	struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
  1288				       u32 max_num_sg);
  1289	struct ib_mr *mlx5_ib_alloc_mr_integrity(struct ib_pd *pd,
  1290						 u32 max_num_sg,
  1291						 u32 max_num_meta_sg);
  1292	int mlx5_ib_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
  1293			      unsigned int *sg_offset);
  1294	int mlx5_ib_map_mr_sg_pi(struct ib_mr *ibmr, struct scatterlist *data_sg,
  1295				 int data_sg_nents, unsigned int *data_sg_offset,
  1296				 struct scatterlist *meta_sg, int meta_sg_nents,
  1297				 unsigned int *meta_sg_offset);
  1298	int mlx5_ib_process_mad(struct ib_device *ibdev, int mad_flags, u32 port_num,
  1299				const struct ib_wc *in_wc, const struct ib_grh *in_grh,
  1300				const struct ib_mad *in, struct ib_mad *out,
  1301				size_t *out_mad_size, u16 *out_mad_pkey_index);
  1302	int mlx5_ib_alloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata);
  1303	int mlx5_ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata);
  1304	int mlx5_query_ext_port_caps(struct mlx5_ib_dev *dev, unsigned int port);
  1305	int mlx5_query_mad_ifc_system_image_guid(struct ib_device *ibdev,
  1306						 __be64 *sys_image_guid);
  1307	int mlx5_query_mad_ifc_max_pkeys(struct ib_device *ibdev,
  1308					 u16 *max_pkeys);
  1309	int mlx5_query_mad_ifc_vendor_id(struct ib_device *ibdev,
  1310					 u32 *vendor_id);
  1311	int mlx5_query_mad_ifc_node_desc(struct mlx5_ib_dev *dev, char *node_desc);
  1312	int mlx5_query_mad_ifc_node_guid(struct mlx5_ib_dev *dev, __be64 *node_guid);
  1313	int mlx5_query_mad_ifc_pkey(struct ib_device *ibdev, u32 port, u16 index,
  1314				    u16 *pkey);
  1315	int mlx5_query_mad_ifc_gids(struct ib_device *ibdev, u32 port, int index,
  1316				    union ib_gid *gid);
  1317	int mlx5_query_mad_ifc_port(struct ib_device *ibdev, u32 port,
  1318				    struct ib_port_attr *props);
  1319	int mlx5_ib_query_port(struct ib_device *ibdev, u32 port,
  1320			       struct ib_port_attr *props);
  1321	void mlx5_ib_populate_pas(struct ib_umem *umem, size_t page_size, __be64 *pas,
  1322				  u64 access_flags);
  1323	void mlx5_ib_copy_pas(u64 *old, u64 *new, int step, int num);
  1324	int mlx5_ib_get_cqe_size(struct ib_cq *ibcq);
  1325	int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev);
  1326	int mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev);
  1327	struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
  1328						      struct mlx5r_cache_rb_key rb_key,
  1329						      bool persistent_entry);
  1330	
  1331	struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
  1332					       int access_flags, int access_mode,
  1333					       int ndescs);
  1334	
  1335	int mlx5_ib_check_mr_status(struct ib_mr *ibmr, u32 check_mask,
  1336				    struct ib_mr_status *mr_status);
  1337	struct ib_wq *mlx5_ib_create_wq(struct ib_pd *pd,
  1338					struct ib_wq_init_attr *init_attr,
  1339					struct ib_udata *udata);
  1340	int mlx5_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata);
  1341	int mlx5_ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *wq_attr,
  1342			      u32 wq_attr_mask, struct ib_udata *udata);
  1343	int mlx5_ib_create_rwq_ind_table(struct ib_rwq_ind_table *ib_rwq_ind_table,
  1344					 struct ib_rwq_ind_table_init_attr *init_attr,
  1345					 struct ib_udata *udata);
  1346	int mlx5_ib_destroy_rwq_ind_table(struct ib_rwq_ind_table *wq_ind_table);
  1347	struct ib_mr *mlx5_ib_reg_dm_mr(struct ib_pd *pd, struct ib_dm *dm,
  1348					struct ib_dm_mr_attr *attr,
  1349					struct uverbs_attr_bundle *attrs);
  1350	
  1351	#ifdef CONFIG_INFINIBAND_ON_DEMAND_PAGING
  1352	int mlx5_ib_odp_init_one(struct mlx5_ib_dev *ibdev);
  1353	int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq);
  1354	void mlx5_ib_odp_cleanup_one(struct mlx5_ib_dev *ibdev);
  1355	int __init mlx5_ib_odp_init(void);
  1356	void mlx5_ib_odp_cleanup(void);
  1357	int mlx5_odp_init_mkey_cache(struct mlx5_ib_dev *dev);
  1358	void mlx5_odp_populate_xlt(void *xlt, size_t idx, size_t nentries,
  1359				   struct mlx5_ib_mr *mr, int flags);
  1360	
  1361	int mlx5_ib_advise_mr_prefetch(struct ib_pd *pd,
  1362				       enum ib_uverbs_advise_mr_advice advice,
  1363				       u32 flags, struct ib_sge *sg_list, u32 num_sge);
  1364	int mlx5_ib_init_odp_mr(struct mlx5_ib_mr *mr);
  1365	int mlx5_ib_init_dmabuf_mr(struct mlx5_ib_mr *mr);
  1366	#else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
  1367	static inline int mlx5_ib_odp_init_one(struct mlx5_ib_dev *ibdev) { return 0; }
  1368	static inline int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev,
  1369					      struct mlx5_ib_pf_eq *eq)
  1370	{
  1371		return 0;
  1372	}
  1373	static inline void mlx5_ib_odp_cleanup_one(struct mlx5_ib_dev *ibdev) {}
  1374	static inline int mlx5_ib_odp_init(void) { return 0; }
  1375	static inline void mlx5_ib_odp_cleanup(void)				    {}
  1376	static inline int mlx5_odp_init_mkey_cache(struct mlx5_ib_dev *dev)
  1377	{
> 1378		return NULL;
  1379	}
  1380	static inline void mlx5_odp_populate_xlt(void *xlt, size_t idx, size_t nentries,
  1381						 struct mlx5_ib_mr *mr, int flags) {}
  1382	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
